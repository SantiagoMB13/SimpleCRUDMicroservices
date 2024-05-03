const express = require('express');
const admin = require('firebase-admin');
const { MongoClient } = require('mongodb');
require('dotenv').config();

const serviceAccount = require('./cruddbkey.json');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});
const app = express();
const PORT = 3300;

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

app.options('/read', (req, res) => {
    // Set CORS headers for preflight requests
    res.setHeader('Access-Control-Allow-Origin', 'http://localhost:1200'); // Replace with your client's origin
    res.setHeader('Access-Control-Allow-Methods', 'POST'); // Allow POST requests
    res.setHeader('Access-Control-Allow-Headers', 'Content-Type'); // Allow Content-Type header
    res.status(200).end();
});

app.post('/read', async (req, res) => {
    const {
        numeroDocumento
    } = req.body.data;

    res.setHeader('Access-Control-Allow-Origin', 'http://localhost:1200'); // Replace with your client's origin
    res.setHeader('Access-Control-Allow-Methods', 'POST'); // Allow POST requests
    res.setHeader('Access-Control-Allow-Headers', 'Content-Type'); // Allow Content-Type header

    function formatDate(date) { const day = date.getDate().toString().padStart(2, '0'); 
    const month = (date.getMonth() + 1).toString().padStart(2, '0');
    const year = date.getFullYear(); 
    return `${day}-${month}-${year}`; 
    }

    const connection = await getConnection();
    const collection = connection.db('MainDB').collection('usuarios');
    const logCollection = connection.db('MainDB').collection('log');

    try {
        const doc = await collection.findOne({ numeroDocumento: numeroDocumento });
        
        if (!doc) {
            return res.status(200).json({ result: {
                mensaje: 'verificar inexistente',
                usuario: null
            }});
        }

        await logCollection.insertOne({
            id: numeroDocumento,
            tipo: 'Buscar',
            fecha: formatDate(new Date())
        });    

        return res.status(200).json({ result: {
            mensaje: 'exito',
            usuario: doc
        }});
    } catch (error) {
        return res.status(500).json({ result: {
            mensaje: 'error',
            usuario: null
        }});
    }
});

app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
