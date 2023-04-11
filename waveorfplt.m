function waveorfplt(y,orfs,i,j,k,titles,sigle,isC,anotesF,slv,wavplt)
    % 本函数只是用来将 小波图和对应的orfs 图画出来
    % 期中 y 表示对应的小波系数谱
    % orfs 是对应的开放阅读框信息，这里用的是struct
    % i,j ,k 是对应的 行列和第几个图用于subplot
    % title 是标题
    % 作图函数
    % 画出orfs的方向
    % anotesF 是否标注 位置信息
    if ~sigle
        subplot(i,j,k);
    end
    if wavplt
        imagesc(abs(y));
        colorbar;
        hold on;
    end
    ylen = length(y);
    colorA = ["#33a3dc","#7bbfea","#228fbd","#2468a2","#009ad6","#008792"];
%     slv = [0.0200 0.0250]; % 0.005-0.005-0.030 % [[0.0050 0.0100 0.0150 | 0.0200 0.0250 0.0300]]
%     contour(abs(y),slv,"LineColor","b");
    contour(abs(y),[0.02  0.02 ],"LineColor","r");
    hold on;
    contour(abs(y),[0.025 0.025],"LineColor","b");
%     CArrA = contour(abs(y),hlevel,'ShowText',"on","LineColor","w");
    for i = 1:height(orfs)
        segs = orfs(i,:);
        cindex = segs.shift;
        yindex = cindex*1.1;
        x = segs.start;
        y = segs.stop;
        if segs.shift < 0
            yindex = abs(yindex) + 5;
            cindex = abs(cindex) + 3;
        end
        if segs.iscomplete | isC % && segs.shift > 0 && segs.start >= 9
            line([segs.start segs.stop],[yindex yindex],'lineWidth',1,'Color',colorA(cindex));
            line([x x],[yindex-0.4 yindex + 0.4],'lineWidth',1,'Color',colorA(cindex));
            line([y y-0.5],[yindex-0.2 yindex + 0.2],'lineWidth',1.5,'Color',colorA(cindex));
            if anotesF
                text((segs.start+segs.stop)*0.5,yindex+0.3,num2str(i),'HorizontalAlignment','center','FontSize',9,'Color','black');
                text(x,yindex+0.3,num2str(x),'HorizontalAlignment','center','FontSize',9,'Color','white');
                text(y,yindex+0.5,num2str(y),'HorizontalAlignment','center','FontSize',9,'Color','white');
            end
        end
            
    %         legend(["+1","+2","+3","-1","-2","-3"],"Location","eastoutside");
    end
    title(titles);
    for i = 0:5
        if i==0
            s = 1;
        else
            s = i*3;
        end
        line([1 ylen],[s s],'lineWidth',1,'Color',"#d3d7d4");
    end
    yticks([1 3 6 9 12 15]);
    hold off;
end
