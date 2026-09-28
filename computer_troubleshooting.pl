% ============================================================
% COMPUTER TROUBLESHOOTING EXPERT SYSTEM
% ============================================================

:- dynamic user_symptom/1.

% ============================================================
% FACTS / AVAILABLE SYMPTOMS
% ============================================================

symptom(computer_slow).
symptom(computer_overheating).
symptom(computer_not_starting).
symptom(blue_screen).
symptom(random_shutdown).
symptom(no_internet).
symptom(wifi_not_connecting).
symptom(internet_slow).
symptom(no_sound).
symptom(sound_distorted).
symptom(screen_flickering).
symptom(black_screen).
symptom(battery_draining).
symptom(computer_freezing).
symptom(app_crashing).
symptom(high_cpu_usage).
symptom(low_storage).
symptom(mouse_not_working).
symptom(keyboard_not_working).
symptom(printer_not_working).
symptom(usb_not_detected).
symptom(computer_noisy).


% ============================================================
% RULES
% ============================================================

rule(slow_computer,
     [computer_slow, high_cpu_usage]).

rule(slow_computer_storage,
     [computer_slow, low_storage]).

rule(overheating,
     [computer_overheating, computer_noisy]).

rule(shutdown_overheating,
     [computer_overheating, random_shutdown]).

rule(startup_failure,
     [computer_not_starting, black_screen]).

rule(system_crash,
     [blue_screen, computer_freezing]).

rule(network_failure,
     [no_internet, wifi_not_connecting]).

rule(slow_network,
     [internet_slow, no_internet]).

rule(audio_problem,
     [no_sound, sound_distorted]).

rule(display_problem,
     [screen_flickering, black_screen]).

rule(battery_problem,
     [battery_draining, computer_slow]).

rule(freezing_problem,
     [computer_freezing, high_cpu_usage]).

rule(application_problem,
     [app_crashing, low_storage]).

rule(mouse_problem,
     [mouse_not_working, usb_not_detected]).

rule(keyboard_problem,
     [keyboard_not_working, usb_not_detected]).

rule(printer_problem,
     [printer_not_working, usb_not_detected]).

rule(storage_problem,
     [low_storage, computer_slow]).

rule(cpu_problem,
     [high_cpu_usage, computer_overheating]).

rule(usb_problem,
     [usb_not_detected, mouse_not_working]).

rule(performance_problem,
     [computer_slow, computer_freezing]).

rule(system_instability,
     [blue_screen, random_shutdown]).

rule(power_problem,
     [computer_not_starting, random_shutdown]).

rule(network_performance,
     [internet_slow, wifi_not_connecting]).


% ============================================================
% SOLUTIONS / RECOMMENDATIONS
% ============================================================

solution(slow_computer,
    'Close unnecessary applications and check CPU usage.').

solution(slow_computer_storage,
    'Free disk space by removing unnecessary files.').

solution(overheating,
    'Clean the cooling vents and make sure the fans are working.').

solution(shutdown_overheating,
    'Check cooling, clean the fans, and avoid blocking ventilation.').

solution(startup_failure,
    'Check the power connection and display connection.').

solution(system_crash,
    'Check recently installed drivers and run a system diagnostic.').

solution(network_failure,
    'Restart the router and check the Wi-Fi connection.').

solution(slow_network,
    'Restart the router and check the network connection speed.').

solution(audio_problem,
    'Check the volume, audio output device, and audio drivers.').

solution(display_problem,
    'Check the display cable, graphics driver, and monitor.').

solution(battery_problem,
    'Check battery health and reduce unnecessary background applications.').

solution(freezing_problem,
    'Check CPU usage and close unnecessary applications.').

solution(application_problem,
    'Free storage space and update or reinstall the application.').

solution(mouse_problem,
    'Reconnect the mouse and check the USB port.').

solution(keyboard_problem,
    'Reconnect the keyboard and check the USB port.').

solution(printer_problem,
    'Check the printer connection, power, and printer driver.').

solution(storage_problem,
    'Delete unnecessary files and move large files to external storage.').

solution(cpu_problem,
    'Check background processes and clean the cooling system.').

solution(usb_problem,
    'Reconnect the USB device and try another USB port.').

solution(performance_problem,
    'Close unnecessary programs and check system resources.').

solution(system_instability,
    'Check system drivers and run hardware diagnostics.').

solution(power_problem,
    'Check the power cable, charger, and power supply.').

solution(network_performance,
    'Restart the router and check Wi-Fi signal strength.').


% ============================================================
% FORWARD CHAINING
% ============================================================

forward_chain :-
    findall(
        Goal,
        (
            rule(Goal, Conditions),
            all_conditions_are_facts(Conditions)
        ),
        Goals0
    ),
    sort(Goals0, Goals),
    (
        Goals = []
        ->
        write('No rule was triggered by the current symptoms.'), nl
        ;
        show_forward_results(Goals)
    ).


all_conditions_are_facts([]).

all_conditions_are_facts([Condition|Rest]) :-
    user_symptom(Condition),
    all_conditions_are_facts(Rest).


show_forward_results([]).

show_forward_results([Goal|Rest]) :-
    solution(Goal, Answer),
    write('Rule triggered: '),
    write(Goal),
    nl,
    write('Recommendation: '),
    write(Answer),
    nl,
    nl,
    show_forward_results(Rest).


% ============================================================
% BACKWARD CHAINING
% ============================================================

backward_prove(Goal) :-
    user_symptom(Goal).

backward_prove(Goal) :-
    rule(Goal, Conditions),
    backward_conditions(Conditions).


backward_conditions([]).

backward_conditions([Condition|Rest]) :-
    backward_prove(Condition),
    backward_conditions(Rest).


backward_results :-
    findall(
        Goal,
        (
            rule(Goal, Conditions),
            backward_conditions(Conditions)
        ),
        Goals0
    ),
    sort(Goals0, Goals),
    (
        Goals = []
        ->
        write('No conclusion reached using backward chaining.'), nl
        ;
        show_backward_results(Goals)
    ).


show_backward_results([]).

show_backward_results([Goal|Rest]) :-
    solution(Goal, Answer),
    write('Goal proved: '),
    write(Goal),
    nl,
    write('Recommendation: '),
    write(Answer),
    nl,
    nl,
    show_backward_results(Rest).


% ============================================================
% EXPLANATION FACILITY
% ============================================================

explanation_results :-
    findall(
        Goal,
        (
            rule(Goal, Conditions),
            all_conditions_are_facts(Conditions)
        ),
        Goals0
    ),
    sort(Goals0, Goals),
    (
        Goals = []
        ->
        write('No explanation available.'), nl
        ;
        show_explanations(Goals)
    ).


show_explanations([]).

show_explanations([Goal|Rest]) :-
    explain(Goal),
    nl,
    show_explanations(Rest).


explain(Goal) :-
    rule(Goal, Conditions),
    all_conditions_are_facts(Conditions),
    solution(Goal, Answer),

    write('Goal: '),
    write(Goal),
    nl,

    write('Facts used: '),
    write(Conditions),
    nl,

    write('Rule applied: '),
    write(Goal),
    write(' <- '),
    write(Conditions),
    nl,

    write('Conclusion: '),
    write(Answer),
    nl.


% ============================================================
% USER INPUT
% ============================================================

input_symptoms(0).

input_symptoms(N) :-
    N > 0,

    write('Enter symptom: '),
    read(Symptom),

    (
        symptom(Symptom)
        ->
        assertz(user_symptom(Symptom)),
        N1 is N - 1,
        input_symptoms(N1)

        ;

        write('Invalid symptom. Please enter a symptom from the list.'),
        nl,
        input_symptoms(N)
    ).


% ============================================================
% DISPLAY AVAILABLE SYMPTOMS
% ============================================================

show_symptoms :-
    forall(
        symptom(S),
        (
            write('- '),
            write(S),
            nl
        )
    ).


% ============================================================
% RUN DIAGNOSIS
% ============================================================

run_diagnostic :-

    retractall(user_symptom(_)),

    write('============================================'), nl,
    write(' COMPUTER TROUBLESHOOTING EXPERT SYSTEM'), nl,
    write('============================================'), nl,
    nl,

    write('Available symptoms:'), nl,
    show_symptoms,
    nl,

    write('How many symptoms do you want to enter? '),
    read(N),

    (
        integer(N),
        N > 0

        ->

        input_symptoms(N),

        nl,
        write('----------- FORWARD CHAINING -----------'), nl,
        forward_chain,

        nl,
        write('----------- BACKWARD CHAINING -----------'), nl,
        backward_results,

        nl,
        write('----------- EXPLANATION -----------'), nl,
        explanation_results,

        nl

        ;

        write('Please enter a valid positive number.'),
        nl
    ).


% ============================================================
% VIEW KNOWLEDGE BASE
% ============================================================

view_knowledge :-

    write('----------- FACTS -----------'), nl,

    forall(
        symptom(S),
        (
            write('symptom('),
            write(S),
            write(').'),
            nl
        )
    ),

    nl,

    write('----------- RULES -----------'), nl,

    forall(
        rule(G, C),
        (
            write(G),
            write(' <- '),
            write(C),
            nl
        )
    ).


% ============================================================
% VIEW RULES
% ============================================================

view_rules :-

    write('----------- RULES -----------'), nl,

    forall(
        rule(G, C),
        (
            write(G),
            write(' <- '),
            write(C),
            nl
        )
    ).


% ============================================================
% MAIN MENU
% ============================================================

start :-
    menu.


menu :-

    nl,
    write('================================'), nl,
    write(' COMPUTER TROUBLESHOOTING SYSTEM'), nl,
    write('================================'), nl,

    write('1. Run Diagnosis'), nl,
    write('2. View Knowledge Base'), nl,
    write('3. View Rules'), nl,
    write('4. Exit'), nl,

    write('Select option: '),
    read(Choice),

    handle_choice(Choice).


% ============================================================
% MENU OPTIONS
% ============================================================

handle_choice(1) :-
    run_diagnostic,
    menu.


handle_choice(2) :-
    view_knowledge,
    menu.


handle_choice(3) :-
    view_rules,
    menu.


handle_choice(4) :-
    write('Thank you for using the Expert System.'),
    nl.


handle_choice(_) :-
    write('Invalid option. Please enter 1, 2, 3, or 4.'),
    nl,
    menu.