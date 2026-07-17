const http = require('http')

const request = http.get(
    {
        host: '127.0.0.1',
        port: process.env.PORT || 3000,
        path: '/',
        timeout: 2000,
    },
    (response) => {
        response.resume()
        process.exit(response.statusCode === 200 ? 0 : 1)
    }
)

request.on('timeout', () =>
    request.destroy(new Error('Health check timed out'))
)
request.on('error', () => process.exit(1))
