function [res,pos] = osgPos(contDat,osg,coverOrf,needpos)
    % 本函数用于返回 orf片段内的高能区域的能量集中趋势，给出所在位置信息
    % 分别是25% 50% 75% 100%区间内
    % needpos 只是提示是否要返回具体的 百分位名称，不参与实际的数据提取
    %   |0    |12.5     |25    |37.5   |50     |62.5   |75     |87.5   |100
    if needpos
        pos = round(linspace(0,1,9)*100,2); % 给出每段的字符串名称
    end
    csg = contDat(coverOrf,:); % 选取在该osg内的高能区域
    if height(csg) == 0
        res = zeros(1,9);
    else
        segMents = linspace(osg.start,osg.stop,9); % 按要求将区间进行分段为8个区间9段线

        div = 0.5*(osg.start - osg.stop)/8; % 在这个范围内的高能区域
        leftD = csg.left - segMents; % 计算左端点距离标定点的距离
        rightD = csg.right - segMents; % 计算右端点距离标定点的距离
        res = abs(leftD) <= abs(div) | abs(rightD) <=abs(div); 
    end
end
