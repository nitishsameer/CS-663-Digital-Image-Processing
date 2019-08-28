function output = add_noise(input)
output = input + 0.05*(max(input(:)) - min(input(:)))*randn(size(input));
end