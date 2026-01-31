def otp_email_template(otp: str) -> str:
    return f"""
    <html>
        <body>
            <h2>Verify your email</he>
            <p>Your otp is:</p>
            <h1>{otp}</h1>
            <p>This otp is valid for 5 minutes</p>
        </body>
    </html>
    """