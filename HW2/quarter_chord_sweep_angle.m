function angle = quarter_chord_sweep_angle(mSweepAngle, aspectRatio, taperRatio)
  angle = atand(tand(mSweepAngle)-(1/aspectRatio)*((1-taperRatio)/(1+taperRatio)));
end
