COMPUTER TROUBLESHOOTING EXPERT SYSTEM USING PROLOG

1. SOFTWARE REQUIREMENT

* SWI-Prolog
* Windows operating system

2. HOW TO RUN THE SYSTEM

Step 1:
Install SWI-Prolog on the computer.

Step 2:
Open SWI-Prolog.

Step 3:
Open the project folder or navigate to the project folder.

Step 4:
Load the Prolog program using:

consult('computer_troubleshooting.pl').

Step 5:
Start the expert system using:

start.

3. HOW TO USE THE SYSTEM

After starting the system, the main menu will be displayed.

The system provides options for:

1. Enter symptoms and diagnose
2. View knowledge base
3. View rules
4. Run forward chaining
5. Run backward chaining
6. Show explanation
7. Exit

When entering a symptom, enter the corresponding Prolog term followed by a period.

Example:

computer_slow.
high_cpu_usage.

The system then evaluates the entered symptoms and provides the relevant conclusion and recommendation.

4. EXAMPLE

Input symptoms:

computer_slow.
high_cpu_usage.

The system can identify:

slow_computer

Recommendation:

Close unnecessary applications and check CPU usage.

5. KNOWLEDGE BASE

The system contains computer troubleshooting symptoms, rules, and recommendations.

The knowledge base contains 22 symptom facts and 23 troubleshooting rules.

6. INFERENCE METHODS

The system demonstrates:

* Forward chaining
* Backward chaining

An explanation facility is also provided to show the facts and rule used to reach a conclusion.
