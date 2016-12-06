function r = dirich_rnd(a)

    Y = gamrnd(a,1);
    r = Y./sum(Y);

end

