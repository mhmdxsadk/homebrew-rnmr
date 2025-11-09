import os
import sys
import click
from colorama import Fore, Style, init

init(autoreset=True)


class RNMR:
    @staticmethod
    def isInputValid(ctx, param, value):
        if not os.path.exists(value):
            click.echo(
                f"{Fore.RED}Error:{Style.RESET_ALL} Input path '{value}' does not exist."
            )
            sys.exit(1)
        return value

    @staticmethod
    def isOutputValid(ctx, param, value):
        if value:
            value = value.rstrip("/\\")
            if not value:
                click.echo(
                    f"{Fore.RED}Error:{Style.RESET_ALL} Invalid output path provided."
                )
                sys.exit(1)
            if os.path.exists(value):
                click.echo(
                    f"{Fore.RED}Error:{Style.RESET_ALL} Output path '{value}' already exists."
                )
                sys.exit(1)
            parent_dir = os.path.dirname(value)
            if parent_dir and not os.path.isdir(parent_dir):
                click.echo(
                    f"{Fore.RED}Error:{Style.RESET_ALL} Output directory '{parent_dir}' does not exist."
                )
                sys.exit(1)
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
        type=click.Path(exists=False),
        callback=isOutputValid,
    )
    def rename(inputpath, outputpath):
        try:
            os.rename(inputpath, outputpath)
            cleaned_input = inputpath.rstrip("/\\")
            cleaned_output = outputpath.rstrip("/\\")
            click.echo(
                f"Renamed {Fore.RED}{cleaned_input}{Style.RESET_ALL} to {Fore.YELLOW}{cleaned_output}{Style.RESET_ALL}"
            )
            sys.exit(0)
        except Exception as e:
            click.echo(f"{Fore.RED}Unexpected Error:{Style.RESET_ALL} {str(e)}")
            sys.exit(2)