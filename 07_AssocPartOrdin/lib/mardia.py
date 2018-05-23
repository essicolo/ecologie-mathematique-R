import numpy as np
import scipy as sp

def mardia_test(data, cov=True):
    if not isinstance(data, np.ndarray):
        raise ValueError('data must be a numpy array')
    if data.shape[1] < 2:
        raise ValueError("number of variables must be equal or greater than 2")

    n = data.shape[0]
    p = data.shape[1]

    data_c = np.apply_along_axis(func1d=lambda x: x-np.mean(x), axis=0, arr=data)

    if cov:
        S = ((n - 1)/n) * np.cov(data.T)
    else:
        S = np.cov(data.T)

    D = data_c.dot(np.linalg.inv(S).dot(data_c.T))
    g1p = np.sum(D**3)/n**2
    g2p = np.sum(np.diag((D**2)))/n
    df = p * (p + 1) * (p + 2)/6
    k = (p + 1) * (n + 1) * (n + 3)/(n * ((n + 1) * (p + 1) - 6))

    small_skew = n * k * g1p/6
    skew = n * g1p/6
    kurt = (g2p - p * (p + 2)) * np.sqrt(n/(8 * p * (p + 2)))
    p_skew = sp.stats.chi2.sf(x=skew, df=df)
    p_small = sp.stats.chi2.sf(x=small_skew, df=df)
    p_kurt = 2 * sp.stats.norm.sf(np.abs(kurt))

    return {'g1p': g1p, 'chi_skew': skew, 'P-value skew': p_skew, 'Chi small skew': small_skew, 'P-value small': p_small, 'g2p': g2p, 'Z kurtosis': kurt, 'P-value kurtosis': p_kurt}
