Замените строку с API_URL на ваш IP компьютера

mobile/App.js
```
const API_URL = 'http://192.168.1.100:3000/api'; 
```

Запуск:
```bash
kubectl port-forward --address 0.0.0.0 service/notes-backend-service 3000:3000
```

```bash
cd ~/NotesApp/mobile
npm start
```

Отсканировать в Expo Go на телефоне
