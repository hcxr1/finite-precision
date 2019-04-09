# FinitePrecision

This project proposed a novel approach to estimate the error bounds of floating-point computation using moment-based distribution fitting technique and compared with existing mainstream methods, such as *Monte Carlo Simulation* (MCS), *Interval Arithmetics* (IA), *Affine Arithmetics* (AA), and *Satisfiability Modulo Theory* (SMT).

IA and AA are computed with INTLab toolbox for MATLAB [1] and SMT are computed with Z3 Solver with phyton.
This project investigates the feasibility of using statistical moment to perform bound estimation. By using the polynomial representation of floating point in [2], the method is to estimate the bound through propagation of moments has its root in the works of Y. C. Kuang et al. [3]. The proposed method takes input polynomial model and input distributions for each variables then computes the moment of the polynomial. There is no need to keep track of the bound and interactions between variables in every step of the computation. The net result of interactions between correlated variables are encoded in the moments of the output variable. Then by making use of the moment obtained, the distribution of the output variable can be used to estimate the bounds of the model.

# Reference
[1] S. M. Rump, INTLAB - INTerval LABoratory. Dordrecht: Kluwer Academic Publishers, 1999.<br>
[2] D. Boland and G. A. Constantinides, "Automated Precision Analysis: A Polynomial Algebraic Approach," in Field-Programmable Custom Computing Machines (FCCM), 2010 18th IEEE Annual International Symposium on, 2010, pp. 157-164.<br>
[3] Y. C. Kuang, A. Rajan, M. P.-L. Ooi, and T. C. Ong, "Standard uncertainty evaluation of multivariate polynomial," Measurement, vol. 58, pp. 483-494, 2014.<br>
