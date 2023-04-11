function [res,colNames] = baseOrf(osg,coverOrf,overCover)
%     overCover单条osg 内的高能区域能量、区域内高能占比、高能数量、高能位置信息（9个）
%     coverOrf左右的是否存在高能区
    if sum(coverOrf(1:2)~=0)==2
        endCover = 0;
    else
        endCover = 1; % 具有可能性
    end
    isC = osg.iscomplete; % 给出完整性
    if overCover(end) >=0.5% 平均能量较高可能不适合PC
        pwOver = 0;
    else
        pwOver = 1; % 具有可能性
    end
    
    res = [endCover isC pwOver osg.length/20]; % 最后给出的是osg的长度用于orf的判定
    colNames = ["edCvPer","orfCpl","pwCvCode","osgLen"];
end