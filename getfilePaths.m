function Spe = getfilePaths(SetInfo, endType,pclnc)
    % 用于提取数据文件的文件路径
    if strcmp(endType,"")
        endType = ".fa";
    end
    SpeT = [SetInfo.Animal,SetInfo.Plant];
    rpath = SetInfo.Path;
    Spe = [];
    for x = SpeT
        if SetInfo.c2 > 0
            for y = pclnc
                Spe = [Spe, rpath+ x+ y+ endType];
            end
        else
            Spe = [Spe rpath + x + endType];
        end
    end
end

