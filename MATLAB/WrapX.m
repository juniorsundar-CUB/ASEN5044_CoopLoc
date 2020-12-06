function [out] = WrapX(in)
    out = in;
    out(3,:) = wrapToPi(out(3,:));
    out(6,:) = wrapToPi(out(6,:));
end
