function Nseq = Seq2NumVector(Seq,code)
    % ���ַ�������תΪ��Ӧ�ı����������� 
    Seq = string(Seq);
    seqArray = char(Seq.split(""));
    seqArray = seqArray(2:end-1);
    Nseq = zeros(length(seqArray),1);
    Nseq(seqArray(:)=='A') = code.A;
    Nseq(seqArray(:)=='C') = code.C;
    Nseq(seqArray(:)=='G') = code.G;
    Nseq(seqArray(:)=='T') = code.T;
end
