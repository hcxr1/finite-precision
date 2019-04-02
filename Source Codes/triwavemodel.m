function Ptriangle = triwavemodel(t)
    Ptriangle = abs(mod((t+pi)/pi, 2)-1);