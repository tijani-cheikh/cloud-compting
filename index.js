// Simple Express app ready-to-test
const express = require('express');
const os = require('os');

const app = express();

const PORT = process.env.PORT || 3000;
const HOST = process.env.HOST || '0.0.0.0'; // 0.0.0.0 -> accessible from LAN; use 127.0.0.1 to restrict

app.get('/', (req, res) => {
  res.send(`
    <h1>Demo ready-ngrok-demo</h1>
    <p>Instance: ${os.hostname()}</p>
    <p>Routes: <a href="/health">/health</a></p>
  `);
});

app.get('/health', (req, res) => {
  res.json({ status: 'ok', host: os.hostname(), time: new Date().toISOString() });
});

app.listen(PORT, HOST, () => {
  console.log(\`App listening on http://\${HOST}:\${PORT}\`);
});
