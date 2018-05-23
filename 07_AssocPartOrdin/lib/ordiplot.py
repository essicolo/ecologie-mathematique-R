import numpy as np
import matplotlib.pylab as plt
from scipy.stats import f as ssf


def wascores(x, w, expand=False):
    """
    Inspired by vegan function wascores https://rdrr.io/rforge/vegan/man/wascores.html to compute species scores.
    x: 2D numpy array of the scores
    w: abundance data
    expand: logical, if True species has a weigthed variance
    """
    wa = np.zeros((w.shape[1], x.shape[1]))
    for i in range(wa.shape[0]):
        wa[i, :] = np.average(x, axis=0, weights=w[:,i])
    if expand:
        x_w = w.sum(axis=1)
        ewa_w = w.sum(axis=0)
        x_cov = np.cov(x.T, fweights=x_w, ddof=1)
        wa_cov = np.cov(wa.T, fweights=ewa_w, ddof=1)
        wa_cov_center = np.average(wa, axis=0, weights=ewa_w)
        mul = np.sqrt(np.diag(x_cov)/np.diag(wa_cov))
        wa = (wa-wa_cov_center)*mul+wa_cov_center
    return(wa)


def ellipse(X, level=0.95, method='deviation', npoints=100):
    """
    X: data, 2D numpy array with 2 columns
    level: confidence level
    method: either 'deviation' (swarning data) or 'error (swarning the mean)'
    npoints: number of points describing the ellipse
    """
    cov_mat = np.cov(X.T)
    dfd = X.shape[0]-1
    dfn = 2
    center = np.apply_along_axis(np.mean, arr=X, axis=0) # np.mean(X, axis=0)
    if method == 'deviation':
        radius = np.sqrt(2 * ssf.ppf(q=level, dfn=dfn, dfd=dfd))
    elif method == 'error':
        radius = np.sqrt(2 * ssf.ppf(q=level, dfn=dfn, dfd=dfd)) / np.sqrt(X.shape[0])
    else:
        raise ValueError("Method should be either 'deviation' or 'error'.")
    angles = (np.arange(0,npoints+1)) * 2 * np.pi/npoints
    circle = np.vstack((np.cos(angles), np.sin(angles))).T
    ellipse = center + (radius * np.dot(circle, np.linalg.cholesky(cov_mat).T).T).T
    return ellipse


def biplot(objects, eigenvectors=None, eigenvalues=None,
           vector_labels=None, object_labels=None, scaling=1, xpc=0, ypc=1,
           show_arrows=True,
           group=None, plot_ellipses=False, confidense_level=0.95,
           axis_label='PC',
           arrow_head_width=None):

    """
    Creates a biplot with:

    Parameters:
        objects: 2D numpy array of scores
        eigenvectors: 2D numpy array of loadings
        eigenvalues: 1D numpy array of eigenvalues, necessary to compute correlation biplot_scores
        vector_labels: 1D numpy array or list of labels for loadings
        object_labels: 1D numpy array or list of labels for objects
        show_arrows: logical
        scaling: either 1 or "distance" for distance biplot, either 2 or "correlation" for correlation biplot
        xpc, ypc: integers, index of the axis to plot. generally xpc=0 and ypc=1 to plot the first and second components
        group: 1D numpy array of categories to color scores
        plot_ellipses: 2D numpy array of error (mean) and deviation (samples) ellipses around groups
        confidense_level: confidense level for the ellipses
        axis_label: string, the text describing the axes
    Returns:
         biplot as matplotlib object
    """
    # select scaling
    if scaling == 1 or scaling == 'distance':
        scores = objects
        loadings = eigenvectors
    elif scaling == 2 or scaling == 'correlation':
        scores = objects.dot(np.diag(eigenvalues**(-0.5)))
        loadings = eigenvectors.dot(np.diag(eigenvalues**0.5))
    else:
        raise ValueError("No such scaling")

    if eigenvectors is None:
        loadings=np.array([[0, 0]]) # to include in the computation of plot limits

    # draw the cross
    plt.axvline(0, ls='solid', c='grey', linewidth=0.5)
    plt.axhline(0, ls='solid', c='grey', linewidth=0.5)

    # draw the ellipses
    if group is not None and plot_ellipses:
        groups = np.unique(group)
        for i in range(len(groups)):
            mean = np.mean(scores[group==groups[i], :], axis=0)
            plt.text(mean[0], mean[1], groups[i],
                     ha='center', va='center', color='k', size=15)
            ell_dev = ellipse(X=scores[group==groups[i], :], level=confidense_level, method='deviation')
            ell_err = ellipse(X=scores[group==groups[i], :], level=confidense_level, method='error')
            plt.fill(ell_err[:,0], ell_err[:,1], alpha=0.6, color='grey')
            plt.fill(ell_dev[:,0], ell_dev[:,1], alpha=0.2, color='grey')

    # plot scores
    if group is None:
        if object_labels is None:
            plt.scatter(scores[:,xpc], scores[:,ypc])
        else:
            for i in range(scores.shape[0]):
                #print('i=', i)
                #print(scores[i,xpc], scores[i,ypc])
                plt.text(scores[i, xpc], scores[i, ypc], object_labels[i],
                         color = 'blue', ha = 'center', va = 'center')
    else:
        if object_labels is None:
            for i in range(len(np.unique(group))):
                cond = group == np.unique(group)[i]
                plt.plot(scores[cond, 0], scores[cond, 1], 'o')
        else:
            for i in range(len(np.unique(group))):
                cond = group == np.unique(group)[i]
                scores_gr = scores[cond, 0]
                for j in range(scores_gr.shape[0]):
                    plt.text(scores[j, xpc], scores[j, ypc], object_labels[j],
                             ha = 'center', va = 'center')

    # plot loadings
    if eigenvectors is not None:
        if show_arrows:
            if arrow_head_width is None:
                arrow_head_width = np.ptp(objects)/100
            for i in range(loadings.shape[0]):
                plt.arrow(0, 0, loadings[i, xpc], loadings[i, ypc],
                          color = 'black', head_width=arrow_head_width)

        # plot loading labels
        if vector_labels is None:
            plt.plot(loadings[:, xpc], loadings[:, ypc], marker='+', color='red', ls='None')
        else:
            if show_arrows:
                expand_load_text = 1.15
            else:
                expand_load_text = 1
            for i in range(loadings.shape[1]):
                plt.text(loadings[i, xpc]*expand_load_text, loadings[i, ypc]*expand_load_text, vector_labels[i],
                         color = 'black', ha = 'center', va = 'center') # , fontsize=20

    # axis labels
    plt.xlabel(axis_label + str(xpc+1))
    plt.ylabel(axis_label + str(ypc+1))

    # axis limit
    xlim = [np.hstack((loadings[:, xpc], scores[:,xpc])).min(),
            np.hstack((loadings[:, xpc], scores[:,xpc])).max()]
    margin_x = 0.05*(xlim[1]-xlim[0])
    xlim[0]=xlim[0]-margin_x
    xlim[1]=xlim[1]+margin_x

    ylim = [np.hstack((loadings[:, ypc], scores[:,ypc])).min(),
            np.hstack((loadings[:, ypc], scores[:,ypc])).max()]
    margin_y = 0.05*(ylim[1]-ylim[0])
    ylim[0]=ylim[0]-margin_y
    ylim[1]=ylim[1]+margin_y
    plt.xlim(xlim)
    plt.ylim(ylim)


def triplot(objects, eigenvectors, species, eigenvalues=None,
           labels=None, xpc=0, ypc=1,
           axis_label='PC',
           arrow_head_width=None,
           arrow_scale = 1):
    """
    objects, species and eigenvectors are pandas.DataFrames
    arrow_scale: scaling the arrows. if 0, automatic scaling of arrows where the longuest arrow equal 2/3 of the farthest score
    """
    site_scores = objects.iloc[:, [xpc, ypc]]
    species_scores = species.iloc[:, [xpc, ypc]]
    loadings = eigenvectors


    # draw the cross
    plt.axvline(0, ls='solid', c='gray')
    plt.axhline(0, ls='solid', c='gray')

    # plot scores
    ## sites

    for i in range(site_scores.shape[0]):
        plt.text(x=site_scores.iloc[i,0],
                 y=site_scores.iloc[i,1],
                 s=site_scores.index.values[i],
                 color='black')
    ## species
    for i in range(species_scores.shape[0]):
        plt.text(x=species_scores.iloc[i,0],
                 y=species_scores.iloc[i,1],
                 s=species_scores.index.values[i],
                 color='red')

    # plot loadings
    if arrow_scale == 0:
        x_comb = np.hstack((species_scores.iloc[:,0], site_scores.iloc[:,0]))
        y_comb = np.hstack((species_scores.iloc[:,1], site_scores.iloc[:,1]))
        x_rad = np.max(np.abs(x_comb))
        y_rad = np.max(np.abs(y_comb))
        rad = np.max(np.hstack((x_rad, y_rad))) * 0.666
        load_rad = loadings.apply(lambda x: np.sqrt(x[0]**2 + x[1]**2), axis=1).max()
        arrow_scale = rad/load_rad
    if arrow_head_width is None:
        arrow_head_width = np.ptp(objects.as_matrix())/100
    for i in range(loadings.shape[0]):
        plt.arrow(0, 0,
              loadings.iloc[i,0]*arrow_scale,
              loadings.iloc[i,1]*arrow_scale,
              color = 'blue', head_width=arrow_head_width)

    # plot biplot scores (X variables)
    margin_score_labels = 0.1
    for i in range(loadings.shape[0]):
        plt.text(x=loadings.iloc[i,0]*(arrow_scale+margin_score_labels),
             y=loadings.iloc[i,1]*(arrow_scale+margin_score_labels),
             s = loadings.index.values[i],
             color='blue')

    # axis labels
    plt.xlabel(axis_label + str(xpc+1))
    plt.ylabel(axis_label + str(ypc+1))

    #
    # amalgamate all the values to define the limits in X and Y
    allX = np.hstack((species_scores.iloc[:,0],
                      site_scores.iloc[:,0],
                      loadings.iloc[:,0]*(arrow_scale+margin_score_labels)))
    allY = np.hstack((species_scores.iloc[:,1],
                      site_scores.iloc[:,1],
                      loadings.iloc[:,1]*(arrow_scale+margin_score_labels)))
    margin_plot = 1.1
    plt.xlim([np.min(allX)*margin_plot, np.max(allX)*margin_plot])
    plt.ylim([np.min(allY)*margin_plot, np.max(allY)*margin_plot])
