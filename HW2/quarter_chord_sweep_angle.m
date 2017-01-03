function angle = quarter_chord_sweep_angle(leadingEdgeSweepAngle, aspectRatio, taperRatio)
  angle = atand(tand(leadingEdgeSweepAngle)-(1/aspectRatio)*((1-taperRatio)/(1+taperRatio)));
end
