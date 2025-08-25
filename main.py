# Imports
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import os
import seaborn as sns


def savefig(path, size=[4, 3]):
    # Automatically create directories if needed
    os.makedirs(os.path.dirname(path), exist_ok=True)

    # Default fig size and tight layout
    plt.gcf().set_size_inches(*size)
    plt.tight_layout(pad=0)

    plt.savefig(path, bbox_inches="tight")
    plt.clf()


def main():

    # Set seaborn style
    sns.set_style("whitegrid")

    # Example dataframe with random data
    df = pd.DataFrame(
        {
            "x": np.random.rand(100),
            "y": np.random.rand(100),
            "type": np.random.choice(["a", "b"], 100),
        }
    )

    # Example Plot:
    plot = sns.lineplot(data=df, x="x", y="y", hue="type")

    # Labels, limits, etc..
    plot.set(xlabel="x", ylabel="y")
    plot.set_xlim(left=0, right=1)
    plot.set_ylim([0, 1])

    path = "figs/example_plot.pdf"
    print("Plotting and saving figure in '{}'".format(path))
    savefig(path)


if __name__ == "__main__":
    main()
