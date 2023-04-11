function [contS,C] = contScope(y,hlevel,outType,showF)
    % 获取小波系数的等高图线框信息
    % y 小波变换系数
    % hlevel 等高线 
    % 结果:等高,左,右, 上, 下,宽,高,点数
    %   1   2  3  4  5  6  7  8
    % hlevel = [0.0200 0.0250]; 
    % 0.005-0.005-0.030 % [[0.0050 0.0100 0.0150 | 0.0200 0.0250 0.0300]]
    % 求解每个等高线的覆盖范围
    % x轴上的范围 y轴上的范围

    %% 对 小波图确定高度图 范围
    if showF
        imagesc(abs(y));
        hold on;
%         hlevel = [0.0200 0.0250]; % 0.005-0.005-0.030 % [[0.0050 0.0100 0.0150 | 0.0200 0.0250 0.0300]]
        contour(abs(y),hlevel,'ShowText',"on","LineColor","w");
        colorbar;
        hold off;
    end
    %%
    C = contours(abs(y),hlevel);
    % 获取对应等高线 对应level的范围
    k = 0;
    i = 1;
    contS = []; % 等高线信息
    lenC = length(C);
    if lenC
        while i<lenC
            k = k + 1; % 存储序号
            contS(k,1) = C(1,i); % 等高线的高度 对应小波系数较高的带电性
            len = C(2,i);
            xy = C(:,(i+1):(i+len));  % 该等高线内的值
            x = xy(1,:);
            y = xy(2,:);
            contS(k,2:5) = round([min(x) max(x) min(y) max(y)],1);
            contS(k,6:7) = round([max(x) - min(x) max(y) - min(y)],1);
            contS(k,8) = len;   % 单个等高线的点的数量
            %     contourinfo{k,3} = len;  % 单个等高线的点的数量
            i = i+1+len; % 滑动下标
        end   
    end
    if outType == "table" && lenC
       tnames = ["hlevel","left","right","top","down","width","height","APoints"];
       contS = array2table(contS,"VariableNames",tnames);
    else
       contS = [0];
    end
end
