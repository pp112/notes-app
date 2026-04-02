const express = require('express');
const cors = require('cors');

const app = express();
const port = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());

// In-memory storage
let notes = [
  { id: 1, title: 'Welcome', content: 'Welcome to Notes App!', createdAt: new Date() }
];
let nextId = 2;

// Get all notes
app.get('/api/notes', (req, res) => {
  res.json(notes);
});

// Get single note
app.get('/api/notes/:id', (req, res) => {
  const note = notes.find(n => n.id === parseInt(req.params.id));
  if (!note) {
    return res.status(404).json({ error: 'Note not found' });
  }
  res.json(note);
});

// Create note
app.post('/api/notes', (req, res) => {
  const { title, content } = req.body;
  if (!title || !content) {
    return res.status(400).json({ error: 'Title and content are required' });
  }
  
  const note = {
    id: nextId++,
    title,
    content,
    createdAt: new Date()
  };
  notes.push(note);
  res.status(201).json(note);
});

// Update note
app.put('/api/notes/:id', (req, res) => {
  const id = parseInt(req.params.id);
  const { title, content } = req.body;
  const noteIndex = notes.findIndex(n => n.id === id);
  
  if (noteIndex === -1) {
    return res.status(404).json({ error: 'Note not found' });
  }
  
  notes[noteIndex] = { ...notes[noteIndex], title, content };
  res.json(notes[noteIndex]);
});

// Delete note
app.delete('/api/notes/:id', (req, res) => {
  const id = parseInt(req.params.id);
  const noteIndex = notes.findIndex(n => n.id === id);
  
  if (noteIndex === -1) {
    return res.status(404).json({ error: 'Note not found' });
  }
  
  notes.splice(noteIndex, 1);
  res.status(204).send();
});

app.listen(port, '0.0.0.0', () => {
  console.log(`Backend running on port ${port}`);
});