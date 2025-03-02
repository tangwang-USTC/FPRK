using NormalHermiteSplines

    x = collect(1.0:1.0:20)       # function nodes
    u = x.*0.0                    # function values in nodes
    for i in 6:10
        u[i] = 1.0
    end
    for i in 11:14
        u[i] = -0.2 * i + 3.0
    end

    # An estimation of the 'scaling parameter' the spline being built with
   ε_estimation = estimate_epsilon(x, RK_H1())


   # Build a differentiable spline by values of function in nodes
      # (a spline built with RK_H0 kernel is a continuous function,
      #  a spline built with RK_H1 kernel is a continuously differentiable function,
      #  a spline built with RK_H2 kernel is a twice continuously differentiable function).
      # Here value of the 'scaling parameter' ε is estimated in the interpolate procedure.
      spline = prepare(x, RK_H1())

      # A value of the 'scaling parameter' the spline was built with.
      ε = get_epsilon(spline)

      # An estimation of the Gram matrix condition number
    cond = estimate_cond(spline)

    # Construct the spline for given 'u' values
   spline = construct(spline, u)

   # An estimation of the interpolation accuracy -
   # number of significant digits in the function value interpolation result.
   significant_digits = estimate_accuracy(spline)

   p = collect(1.0:0.2:20)        # evaluation points
   σ = NormalHermiteSplines.evaluate(spline, p)

   label = string("origin")
   pfff = plot(x,u,label=label)
   label = string("fit")
   pfff = plot!(p,σ,label=label)
