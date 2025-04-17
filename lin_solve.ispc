export void lin_solve_ispc(uniform unsigned int n, uniform float a, uniform float c,
                      varying float* x, varying const float* x0)
{
    float inv_c = 1.0f / c;
    for (int sum = 2; sum <= 2 * n; sum++) {
    	foreach (i = 1 ... n + 1) {
	int j = sum - i;
	if (j < 1 || j > n) continue;

	int idx   = i + (n+2) * j;
	int idx_l = (i - 1) + (n+2) * j;
	int idx_r = (i + 1) + (n+2) * j;
	int idx_b = i + (n+2) * (j - 1);
	int idx_t = i + (n+2) * (j + 1);

	x[idx] = (x0[idx] + a * (x[idx_l] + x[idx_r] + x[idx_b] + x[idx_t])) * inv_c;
	}
    }
}
