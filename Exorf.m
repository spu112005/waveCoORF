function [res]= Exorf(y,orfs)
    slv = [0.0200 0.0250]; % 选择的高电性层
    % contoursDat: 等高,左,右, 上, 下,宽,高,点数
    contoursDat = contScope(y,slv,"table",false); % 获取各个高能区域信息
    res = [];
    for i = 1:height(orfs)
        osg = orfs(i,:); % 单条orf信息
        frameLen = 3; % 编码子大小
        winLen = 2; % 半窗长度
        fWin = frameLen * winLen;  % 判断开始结束位置两端的信息，使用了windows的方法
        fWinMat = [-fWin 0 fWin]; % 左右
        startW = osg.start + fWinMat; % 起始点窗口 注意方向处理！！！！
        stopW = osg.stop + fWinMat;   % 终点窗口
        % waveorfplt(y,orfs,1,1,1,filePath(strfind(filePath,'_')+1:(end-3)),true,true,true,[0.025 0.025],false); % 画wave 对应orf 图
        %% orf 与 orf 进行比较 
        % 1. 当前端点窗口内是否有其他orf,注意 正反中是包含自身的仅一次的
            [res1,~]= orfWaveCover1(orfs,startW(1),startW(3),i,'e');        % 1开始端的覆盖 check
            [res2,~]= orfWaveCover1(orfs,stopW(1),stopW(3),i,'e');          % 2终端的覆盖 check
            [res3,~]= orfWaveCover1(orfs,startW(2),stopW(2),i,'c');         % 3跨越的覆盖 check
        %% orf 与 小波区域进行比较
        % 2. 当前端点是否处在 高能区域 
            [res4,~,~]= orfWaveCover2(contoursDat,startW(2),stopW(2),'e');    % 4端点是否存在小波高系数 check 6个
        % 3. 单条osg 内的高能区域能量、区域内高能占比、高能数量、高能位置信息（12个）
            [res5,~,~,~,~]= orfWaveCover3(y,contoursDat,osg,startW(2),stopW(2),'e'); 
        % 4. 一些orf结构信息
            [res6,~] = baseOrf(osg,res4,res5); %3 个
        % 1开始端orf覆盖 2终端orf覆盖 3跨越覆盖 4端点是否存在高能区域
         % 5滑窗内的最高平均能量
        %% 数据存储
        res(i,:)=[res1 res2 res3 res4 res5 res6]; % 左右端覆盖的正反orf数
    end
    if isempty(orfs)
        resR = [0 0 0 0 1];
        res = [resR resR resR resR zeros(1,12) [0 0 0 0]];
    end
end