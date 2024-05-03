const express = require('express');
const admin = require('firebase-admin');
const { MongoClient } = require('mongodb');
require('dotenv').config();

const serviceAccount = require('./cruddbkey.json');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});
const app = express();
const PORT = 3400;

let client;

async function getConnection() {
    if (!client) {
        client = new MongoClient(process.env.DOCKER_URI);
        client.on('connected', () => {
            console.log('Connected to MongoDB Atlas');
        });
        client.on('disconnected', () => {
            console.log('Disconnected from MongoDB Atlas');
        });
        try {
            await client.connect();
        } catch (error) {
            console.error('Error connecting to MongoDB Atlas:', error);
            throw error;
        }
    }
    return client;
}

app.use(express.json());

app.options('/readlog', (req, res) => {
    // Set CORS headers for preflight requests
    res.setHeader('Access-Control-Allow-Origin', 'http://localhost:1200'); // Replace with your client's origin
    res.setHeader('Access-Control-Allow-Methods', 'POST'); // Allow POST requests
    res.setHeader('Access-Control-Allow-Headers', 'Content-Type'); // Allow Content-Type header
    res.status(200).end();
});

app.post('/readlog', async (req, res) => {
    let {
        numeroDocumento,
        opdate,
        operation
    } = req.body.data;

    res.setHeader('Access-Control-Allow-Origin', 'http://localhost:1200'); // Replace with your client's origin
    res.setHeader('Access-Control-Allow-Methods', 'POST'); // Allow POST requests
    res.setHeader('Access-Control-Allow-Headers', 'Content-Type'); // Allow Content-Type header

        // Aplicar transformaciones a la variable operation
        if(operation == "Todas"){
            operation = ''; // No se aplica filtro por operación
        }

        if (!/^\d{2}-\d{2}-\d{4}$/.test(opdate) && opdate) {
            return res.status(200).json( {result: {
                    mensaje: 'verificar fecha',
                    logs: []
                }});
        }

    const connection = await getConnection();
    const logCollection = connection.db('MainDB').collection('log');

    try {
        // Construir el filtro basado en los parámetros de entrada
        let filter = {};
        if (numeroDocumento) filter.id = numeroDocumento;
        if (opdate) {
        filter.opdate = opdate;
    }
        if (operation) filter.tipo = operation;

        // Consultar los registros en el log filtrados por el filtro
        const logDocuments = await logCollection.find(filter).toArray();
        if (logDocuments.length > 0) {
            return res.status(200).json({ result: {
                mensaje: 'exito',
                logs: logDocuments
            }});
        } else {
            return res.status(200).json( {result: {
                mensaje: 'verificar inexistente',
                logs: []
            }});
        }
    } catch (error) {
        return res.status(500).json({ result: {
            mensaje: 'error',
            logs: []
        }});
    }
});

app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
