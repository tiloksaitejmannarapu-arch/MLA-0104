"""
procedural_equivalent.py
-------------------------------------------------------------------
Imperative / procedural re-implementation of a slice of the automobile
fault-diagnosis knowledge base, used only for Stage 7 (Procedural vs
Non-Procedural Paradigm Analysis). It reproduces the SAME conclusions
as the Prolog rule base for the demonstration symptom sets, but every
matching step is written out explicitly instead of being left to a
declarative inference engine.

Run:  python3 procedural_equivalent.py
-------------------------------------------------------------------
"""

RULES = [
    ("weak_battery",
     {"slow_crank", "dashboard_dim_lights", "warning_light_battery"},
     "Battery is weak or discharged. Charge or replace the battery."),
    ("faulty_starter_motor",
     {"clicking_sound", "engine_wont_start"},
     "Starter motor / solenoid fault. Inspect and replace the starter motor."),
    ("faulty_spark_plug",
     {"engine_wont_start", "rough_idle", "reduced_mileage"},
     "Spark plug(s) worn or fouled. Inspect and replace spark plugs."),
    ("clogged_air_filter",
     {"rough_idle", "black_smoke_exhaust", "reduced_mileage"},
     "Air filter is clogged. Clean or replace the air filter."),
    ("faulty_alternator",
     {"dashboard_dim_lights", "warning_light_battery", "stalling"},
     "Alternator is not charging correctly. Test and replace the alternator."),
    ("worn_timing_belt",
     {"engine_noise_ticking", "engine_wont_start"},
     "Timing belt worn or slipping. Inspect and replace the timing belt."),
    ("faulty_ignition_coil",
     {"engine_noise_knocking", "rough_idle", "stalling"},
     "Ignition coil misfiring. Test and replace the ignition coil."),
    ("low_engine_oil",
     {"warning_light_oil", "engine_noise_knocking"},
     "Engine oil level is low. Top up / change oil and check for leaks."),
    ("exhaust_leak",
     {"engine_noise_knocking", "reduced_mileage", "fuel_smell"},
     "Exhaust manifold or gasket leak. Inspect exhaust system for leaks."),
    ("worn_engine_mounts",
     {"abnormal_vibration_idle", "engine_noise_knocking"},
     "Engine mounts worn or broken. Inspect and replace engine mounts."),
    ("wheel_misalignment",
     {"abnormal_vibration_driving"},
     "Wheels are misaligned. Perform wheel alignment."),
    ("low_tire_pressure",
     {"abnormal_vibration_driving", "reduced_mileage"},
     "Tire pressure is low. Check and inflate tires to spec."),
    ("faulty_oxygen_sensor",
     {"black_smoke_exhaust", "reduced_mileage", "warning_light_engine"},
     "Oxygen sensor faulty, causing poor fuel mixture. Replace O2 sensor."),
    ("radiator_overheating_issue",
     {"overheating", "warning_light_engine"},
     "Cooling system fault (radiator/coolant/thermostat). Inspect cooling system."),
    ("worn_brake_pads",
     {"squealing_brakes"},
     "Brake pads worn. Inspect and replace brake pads."),
    ("fuel_pump_failure",
     {"engine_wont_start", "stalling", "fuel_smell"},
     "Fuel pump failure or fuel leak. Inspect and replace the fuel pump."),
]


def forward_chain(symptoms: set) -> list:
    """Explicit, hand-coded matching loop -- the procedural counterpart
    of Prolog's automatic unification + backtracking search."""
    faults = []
    for name, conditions, advice in RULES:
        if conditions <= symptoms:          # manual set-membership check
            faults.append((name, advice))
            print(f"Rule fired -> {name}")
    return faults


def backward_chain(goal: str, symptoms: set) -> bool:
    """Explicit goal check: look the goal up, then manually verify
    every required condition one by one."""
    for name, conditions, advice in RULES:
        if name == goal:
            missing = [c for c in conditions if c not in symptoms]
            if not missing:
                print(f"GOAL PROVED: {goal}")
                print(f"Advice: {advice}")
                return True
            print(f"GOAL FAILED: insufficient evidence for {goal} "
                  f"(missing: {', '.join(missing)})")
            return False
    print(f"{goal} is not a known fault in the rule table.")
    return False


def demo():
    print("=" * 60)
    print("PROCEDURAL EQUIVALENT - TEST CASE 1: weak_battery")
    print("=" * 60)
    symptoms_1 = {"slow_crank", "dashboard_dim_lights", "warning_light_battery"}
    forward_chain(symptoms_1)
    backward_chain("weak_battery", symptoms_1)

    print("\n" + "=" * 60)
    print("PROCEDURAL EQUIVALENT - TEST CASE 2: faulty_starter_motor")
    print("=" * 60)
    symptoms_2 = {"clicking_sound", "engine_wont_start"}
    forward_chain(symptoms_2)
    backward_chain("faulty_starter_motor", symptoms_2)

    print("\n" + "=" * 60)
    print("PROCEDURAL EQUIVALENT - TEST CASE 4: insufficient evidence")
    print("=" * 60)
    symptoms_4 = {"squealing_brakes"}
    forward_chain(symptoms_4)
    backward_chain("fuel_pump_failure", symptoms_4)


if __name__ == "__main__":
    demo()
