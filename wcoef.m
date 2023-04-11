function waveRes = wcoef(NumSeq,levelwave) % 获取小波变换系数
    % 获取小波变换系数
    % NumSeq 是数字化序列
    % 取多少层小波数据
    if (levelwave <=10)
       levelwave = 35; % 数据有效信息主要在前35层
    end
    waveRes = cwt(NumSeq);
    waveRes = waveRes(1:levelwave,:);
%     ans = cwtt(NumSeq);ans = ans(1:15,:); anst = sum(y~=ans,'all');
end

