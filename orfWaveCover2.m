function [res,coverOrf,colNames]= orfWaveCover2(contDat,left,right,isEnd)
% 左右的是否存在高能区，高能区在端点的占比，两端均没被影响的占比
% 函数判断两端是否存在高能片段
    % isend 是用来判断是否对端点还是跨越
%     sprintf("%8d:%8d:%6f,%6f",left,right,slv(1),slv(2));
    if size(contDat,2)==1
        res = [0 0 0 0 1];
        coverOrf = [0 0];
    else
        h_A = height(contDat);
        if isEnd == 'e'
            coverOrf = contDat.left <= [left right] & contDat.right >= [left right]; 
        end
        if isempty(coverOrf) % 异常处理
            res = [0 0 0 0 1];
        else
            res = [sum(coverOrf,1) sum(coverOrf,1)/h_A sum(coverOrf(:,1) + coverOrf(:,2) == 0)/h_A];
        end
    end
    colNames = ["LHiS","RHiS","LHiSPer","RHiSPer","isNoHi"];
end