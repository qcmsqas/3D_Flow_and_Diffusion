function setInit(CsNA0)
    global x y z uz cNA cEG;
    global uzIn uzOut;
    uz(:,:,end)=uz(:,:,end)+uzIn+uzOut;
    %uz(:,:,end-1)=uz(:,:,end-1)+uzIn+uzOut;
end