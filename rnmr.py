#!/Users/moe/miniconda3/envs/tinypdf/bin/python

import os
import click
from colorama import init, Fore, Style

# Initialize colorama for colored output
init(autoreset=True)


class RNMR:  # Renamer
    @staticmethod
    def isInputValid(ctx, param, value):
        if not os.path.exists(value):
            raise click.BadParameter(f"Input path '{value}' does not exist.")
        return value

    @staticmethod
    def isOutputValid(ctx, param, value):
        if value:
            # Remove trailing slashes so folder names are handled correctly.
            value = value.rstrip("/\\")
            if not value:
                raise click.BadParameter("Invalid output path provided.")
            # Check if a file or directory already exists at the output path.
            if os.path.exists(value):
                raise click.BadParameter(f"Output path '{value}' already exists.")
            # Verify that the parent directory exists if one is specified.
            parent_dir = os.path.dirname(value)
            if parent_dir and not os.path.isdir(parent_dir):
                raise click.BadParameter(
                    f"Output directory '{parent_dir}' does not exist."
                )
        return value

    @staticmethod
    @click.command()
    @click.argument(
        "inputpath",
        type=click.Path(exists=True, readable=True),
        callback=isInputValid,
    )
    @click.argument(
        "outputpath",
        type=click.Path(exists=False, readable=True),
        callback=isOutputValid,
    )
    def rename(inputpath, outputpath):
        os.rename(inputpath, outputpath)
        # Clean up trailing slashes for uniform output
        cleaned_input = inputpath.rstrip("/\\")
        cleaned_output = outputpath.rstrip("/\\")
        print(
            f"Renamed {Fore.RED}{cleaned_input}{Style.RESET_ALL} to {Fore.YELLOW}{cleaned_output}{Style.RESET_ALL}"
        )


if __name__ == "__main__":
    RNMR.rename()
