function [res] = osgPower(y,contDat,osg,coverOrf)
    % 给出区间
    csg = contDat(coverOrf&contDat.hlevel<0.025,:); % 选取在该osg内的高能区域
    if height(csg)==0
        res = [0 0];
    else
        ySum = sum(abs(y));        % 案列求和
        left = min(osg.start,osg.stop);
        right= max(osg.start,osg.stop);
        if left <=1;left = 1; end % 判断越界
        if right > length(y);right = length(y); end
        yInter = sum(ySum(left:right));
        startwith = floor(csg.left);
        endwith   = ceil(csg.right);
        startwith(startwith < left) = left;
        endwith(endwith > right) = right;
        res = 0;
        for i = height(csg.left)
            res = res + sum(ySum(startwith(i):endwith(i)));
        end
        res = [res/(right-left) res/yInter];
    end
end
