function [contS,C] = contScope(y,hlevel,outType,showF)
    % ��ȡС��ϵ���ĵȸ�ͼ�߿���Ϣ
    % y С���任ϵ��
    % hlevel �ȸ��� 
    % ���:�ȸ�,��,��, ��, ��,��,��,����
    %   1   2  3  4  5  6  7  8
    % hlevel = [0.0200 0.0250]; 
    % 0.005-0.005-0.030 % [[0.0050 0.0100 0.0150 | 0.0200 0.0250 0.0300]]
    % ���ÿ���ȸ��ߵĸ��Ƿ�Χ
    % x���ϵķ�Χ y���ϵķ�Χ

    %% �� С��ͼȷ���߶�ͼ ��Χ
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
    % ��ȡ��Ӧ�ȸ��� ��Ӧlevel�ķ�Χ
    k = 0;
    i = 1;
    contS = []; % �ȸ�����Ϣ
    lenC = length(C);
    if lenC
        while i<lenC
            k = k + 1; % �洢���
            contS(k,1) = C(1,i); % �ȸ��ߵĸ߶� ��ӦС��ϵ���ϸߵĴ�����
            len = C(2,i);
            xy = C(:,(i+1):(i+len));  % �õȸ����ڵ�ֵ
            x = xy(1,:);
            y = xy(2,:);
            contS(k,2:5) = round([min(x) max(x) min(y) max(y)],1);
            contS(k,6:7) = round([max(x) - min(x) max(y) - min(y)],1);
            contS(k,8) = len;   % �����ȸ��ߵĵ������
            %     contourinfo{k,3} = len;  % �����ȸ��ߵĵ������
            i = i+1+len; % �����±�
        end   
    end
    if outType == "table" && lenC
       tnames = ["hlevel","left","right","top","down","width","height","APoints"];
       contS = array2table(contS,"VariableNames",tnames);
    else
       contS = [0];
    end
end
