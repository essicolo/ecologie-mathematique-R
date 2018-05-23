def box_mtest(data, groups):
    """
    data: a float numpy array
    """
    import scipy as sp
    import numpy as np

    if not isinstance(data, np.ndarray):
        raise ValueError('data must be a numpy array')
    if data.dtype != 'float64':
        raise ValueError('data must be a numpy array of type float64')

    p = data.shape[1]
    unique_categories = list(set(groups)) # lev
    n_categories = len(unique_categories) # nlev

    degrees_of_freedom = np.zeros(n_categories) # dofs
    log_of_det = np.zeros(n_categories)
    covariances = {}
    aux = {}
    pooled = np.zeros((p, p))


    for i in range(len(unique_categories)):
        degrees_of_freedom[i] = data[groups==unique_categories[i], :].shape[0]-1
        covariances[unique_categories[i]] = np.cov(data[groups==unique_categories[i], :].T)
        pooled = pooled + covariances[unique_categories[i]] * degrees_of_freedom[i]
        log_of_det[i] = np.log(np.linalg.det(covariances[unique_categories[i]]))

    if not np.any(degrees_of_freedom) < p:
        print("Warning: one or more categories with less observations than variables")

    tot_dof = degrees_of_freedom.sum()
    tot_inv_dof = (1/degrees_of_freedom).sum()
    pooled = pooled/tot_dof

    boxlog = degrees_of_freedom.sum() * np.log(np.linalg.det(pooled)) - np.sum(log_of_det * degrees_of_freedom)
    co = (((2 * p**2) + (3 * p) - 1)/(6 * (p + 1) * (n_categories - 1))) * (tot_inv_dof - (1/tot_dof))
    chisq = boxlog * (1 - co)
    dof_chisq = (sp.misc.comb(p, 2) + p) * (n_categories - 1)

    p_value = sp.stats.chi2.sf(x=chisq, df=dof_chisq)

    return({'Chi-squared': chisq,
            'Parameter': dof_chisq,
            'P-value': p_value,
            'Covariances': covariances,
            'Pooled covariances': pooled,
            'Log of determinants': log_of_det})
