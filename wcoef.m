function waveRes = wcoef(NumSeq,levelwave) % ��ȡС���任ϵ��
    % ��ȡС���任ϵ��
    % NumSeq �����ֻ�����
    % ȡ���ٲ�С������
    if (levelwave <=10)
       levelwave = 35; % ������Ч��Ϣ��Ҫ��ǰ35��
    end
    waveRes = cwt(NumSeq);
    waveRes = waveRes(1:levelwave,:);
%     ans = cwtt(NumSeq);ans = ans(1:15,:); anst = sum(y~=ans,'all');
end

