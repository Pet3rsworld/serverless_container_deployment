# ─── Base Image ──────────────────────────────────
FROM python:3.11-slim

# ─── Working Directory ──────────────────────────
WORKDIR /app

# ─── Install Dependencies (cached layer) ────────
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# ─── Copy Application Code ──────────────────────
COPY . .

# ─── Document the Port ──────────────────────────
EXPOSE 5000

# ─── Start the Application ──────────────────────
CMD [ "python", "app.py" ]