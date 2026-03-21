from flask import Flask, jsonify
from datetime import datetime
import random
import string

app = Flask(__name__)

def generate_reference():
    """Generate a unique South African payment reference code."""
    date_part = datetime.now().strftime("%Y%m%d")
    random_part = ''.join(random.choices(string.ascii_uppercase + string.digits, k=4))
    return f"PAY-{date_part}-{random_part}"

@app.route("/")
def health_check():
    """Health check endpoint for ECS Fargate."""
    return jsonify({
        "status": "healthy",
        "service": "SA Payment Reference Generator",
        "version": "1.0.0"
    })

@app.route("/generate")
def generate_payment_ref():
    """Generate a new payment reference."""
    reference = generate_reference()
    return jsonify({
        "reference": reference,
        "currency": "ZAR",
        "generated_at": datetime.now().isoformat(),
        "environment": "dev"
    })

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
