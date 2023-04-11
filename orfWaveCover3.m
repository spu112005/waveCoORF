function [res,coverOrf,oPos,pos,colNames]= orfWaveCover3(y,contDat,osg,left,right,isEnd)
% coverOrfCount区域内高能区域数 oPos给出高能区域的分布情况 pw 区域内高能能量总数和高能占能量的占比
    % 3(1)判断orf内是否有 单个高能区域 check (2)所有的高能区域在osg的位置信息 check
    % 4.判断单个orfs内多个高能区域，且平均能量较高   % 5.滑窗内的最高平均能量（作废无法处理）
    % 6.高能区与片段头、尾 吻合百分比  % 7.高能区域在片段中百分比，   % 8.高能区域在短时间能量百分比
    % isend 是用来判断是否对端点还是跨越
%% +3 (1)判断orf内是否有 单个高能区域 (2)所有的高能区域在osg的位置信息
    if size(contDat,2)==1
        res = zeros(1,12);
        coverOrf = 0;
        oPos = zeros(1,9);
        pos  = nan;
    else
        if osg.shift > 0
            coverOrf = contDat.right >= left & contDat.left <=right ; % 给出orf内的高能区域数 包含端点的
        else
            coverOrf = contDat.right >= right & contDat.left <= left ; % 给出orf内的高能区域数 包含端点的
        end
        coverOrfCount = height(contDat(coverOrf & contDat.hlevel<0.025,:)); % 总计符合条件的
        [oPos,pos]= osgPos(contDat,osg,coverOrf,1); % 给出高能区域的分布情况 check
        [pw] = osgPower(y,contDat,osg,coverOrf);% 给出高能区域在osg内的平均能量
        res = [coverOrfCount floor(sum(oPos,1)) pw];
    end
    % 区域内高能区域数
%    平均能量较高反应的是被修饰的机会高，所以不太能翻译
colNames = ["orfHiSum","0","12.5","25","37.5","50","62.5","75","87.5","100","osgHiAvPw","osgHiPwPer"];
end