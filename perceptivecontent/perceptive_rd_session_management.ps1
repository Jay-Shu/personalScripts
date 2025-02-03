<#
                    .SYNOPSIS
                        This script is intended for helping with Remote Desktop Management. To alleviate session resource holds.

                    .DESCRIPTION
                        During the course of a Managed Services Contract it is important that cleanup occurs as we go along.
                    Therefore, when not actively working on the server our sessions must be closed. Freeing up any resources
                    that may be reserved for our suspended session(s).

                    .EXAMPLE
                        Get-RDUserSession -ConnectionBroker

                    .NOTES
                        We will need to include a number of functions to accomplish this task. Additionally, sessions cannot be ended
                    which are still active (not disconnected or suspended).

                    .INPUTS
                    username: Username that will be performing the promoting and demoting. This must be a current Perceptive Manager.
                    password: Password of the username performing the promoting and demoting. This must be a current Perceptive Manager.
                    inserverBin64: Inserver Installation Directory. This is where your executables live.
                    inserverBin64Old: Inserver Installation Directory for solutions from older versions. Prior to Version 7, it was [drive]:\inserver6

                    .LINK
                    https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_operators?view=powershell-7.4
                    about_Operators

                    Changelog:
                        2025-01-15: Added a form for input as opposed to Console only. This form populates values for the ODBC.
                    #>


query session