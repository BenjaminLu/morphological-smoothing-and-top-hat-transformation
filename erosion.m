function intensity = erosion(f, b, radius)
    tmp = zeros(1, radius * radius);
    for position = 1 : radius * radius
        tmp(position) = f(position) - b(position);
    end
    intensity = min(tmp);
end

