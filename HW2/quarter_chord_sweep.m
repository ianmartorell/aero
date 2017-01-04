function angle = quarter_chord_sweep(leadingEdgeSweep, aspectRatio, taperRatio)
  angle = atand(tand(leadingEdgeSweep)-(1/aspectRatio)*((1-taperRatio)/(1+taperRatio)));
end
