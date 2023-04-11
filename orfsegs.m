function orfsSegs = orfsegs(orfs,seqlens)
    % 将orfs 每一段的信息进行提取和处理
    % 相对正反序列开始位置   结束      偏移      是否完整         片段长度     对应正x    y
    % struct('start',[],'stop',[],'shift',[],'iscomplete',[],'length',[],'x',[],'y',[]);
%     orfsSegs = struct('start',[],'stop',[],'length',[],'shift',[],'iscomplete',[],'x',[],'y',[]);
    orfsSegs = struct('length',[],'shift',[],'iscomplete',[],'x',[],'y',[]);
    k = 1;
    for i = 1:6
        ose = orfs(i);
        segLens = ose.Stop-ose.Start;
        j = 1;
        shiftc = i;
        for Segrec = segLens
%             orfsSegs(k).start = ose.Start(j);
%             orfsSegs(k).stop = ose.Stop(j);
            orfsSegs(k).x = ose.Start(j);
            orfsSegs(k).y = ose.Stop(j);
            if i>3
                shiftc = 3 - i;
                orfsSegs(k).y = seqlens-ose.Stop(j);
                orfsSegs(k).x = seqlens-ose.Start(j);
            end
            orfsSegs(k).shift =  shiftc;
            if ose.Stop(j) > seqlens
                orfsSegs(k).iscomplete = 0;
            else
                orfsSegs(k).iscomplete = 1;
            end
            orfsSegs(k).length = Segrec;
            
            j = j + 1;
            k = k + 1;
        end
    %         disp()

    end % end for
    
end
