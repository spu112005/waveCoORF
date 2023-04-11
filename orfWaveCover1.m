function [res,coverOrf,colNames]= orfWaveCover1(orfs,Ends_left,Ends_right,i,isEnd)
% 函数判断orf 开始段的其他orf的覆盖和跨越情况
% isend 是用来判断是否对端点 还是跨越
    h_A = height(orfs); % 获取数组长度
    ind = 1:h_A;
    orfshift = orfs(i,:).shift;
    ind(i) = [];
    orfs = orfs(ind,:);
    if isEnd == 'e'
        coverOrf = Ends_left <= [orfs.stop orfs.start] & [orfs.start orfs.stop] <= Ends_right;% 正链叠加的orf
    else
        if  orfshift <0
            xl = Ends_left <= [orfs.stop orfs.start];
            xr = [orfs.start orfs.stop] <= Ends_right;% 正链叠加的orf
%             coverOrf = (~xor(xl,xr)) & [orfs.shift>0 orfs.shift <0] ; % check对下侧有效
        else % 正链
            xl = Ends_left <= [orfs.start orfs.stop];
            xr = [orfs.stop orfs.start] <= Ends_right;% 正链叠加的orf
%             coverOrf = (~xor(xr,xl)) & [orfs.shift>0 orfs.shift <0];
        end
        coverOrf = (~xor(xl,xr)) & [orfs.shift>0 orfs.shift <0];
    end
    %% 叠加总数 、 左右占比 、完整不受影响的总数占比
    % （1-占比的值可以看出可编码orf的编码能力，或者可以看出不受影响的程度）
    %  
    if h_A ==0 | isempty(coverOrf) | sum(isnan(coverOrf))>0
        res = [0 0 0 0 1]; 
    end
    res = [sum(coverOrf,1) sum(coverOrf,1)/h_A sum(coverOrf(:,1) - coverOrf(:,2) == 0)/h_A]; 
    colNames = ["LOrCSum","ROrCSum","LOrCPer","ROrCPer","OrNoCPer"];
end

