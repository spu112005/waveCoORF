function [res,coverOrf,colNames]= orfWaveCover1(orfs,Ends_left,Ends_right,i,isEnd)
% �����ж�orf ��ʼ�ε�����orf�ĸ��ǺͿ�Խ���
% isend �������ж��Ƿ�Զ˵� ���ǿ�Խ
    h_A = height(orfs); % ��ȡ���鳤��
    ind = 1:h_A;
    orfshift = orfs(i,:).shift;
    ind(i) = [];
    orfs = orfs(ind,:);
    if isEnd == 'e'
        coverOrf = Ends_left <= [orfs.stop orfs.start] & [orfs.start orfs.stop] <= Ends_right;% �������ӵ�orf
    else
        if  orfshift <0
            xl = Ends_left <= [orfs.stop orfs.start];
            xr = [orfs.start orfs.stop] <= Ends_right;% �������ӵ�orf
%             coverOrf = (~xor(xl,xr)) & [orfs.shift>0 orfs.shift <0] ; % check���²���Ч
        else % ����
            xl = Ends_left <= [orfs.start orfs.stop];
            xr = [orfs.stop orfs.start] <= Ends_right;% �������ӵ�orf
%             coverOrf = (~xor(xr,xl)) & [orfs.shift>0 orfs.shift <0];
        end
        coverOrf = (~xor(xl,xr)) & [orfs.shift>0 orfs.shift <0];
    end
    %% �������� �� ����ռ�� ����������Ӱ�������ռ��
    % ��1-ռ�ȵ�ֵ���Կ����ɱ���orf�ı������������߿��Կ�������Ӱ��ĳ̶ȣ�
    %  
    if h_A ==0 | isempty(coverOrf) | sum(isnan(coverOrf))>0
        res = [0 0 0 0 1]; 
    end
    res = [sum(coverOrf,1) sum(coverOrf,1)/h_A sum(coverOrf(:,1) - coverOrf(:,2) == 0)/h_A]; 
    colNames = ["LOrCSum","ROrCSum","LOrCPer","ROrCPer","OrNoCPer"];
end

