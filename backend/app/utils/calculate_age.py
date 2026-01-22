from datetime import date

def calculate_age(dob: date) -> int:
    today = date.today()

    return (
        today.year - date.year - ((today.month, today.day) < (dob.month, dob.day))
    )