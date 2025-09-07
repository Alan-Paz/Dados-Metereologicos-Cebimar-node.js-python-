[
    {
        "id": "72f12ba5c5367ee5",
        "type": "tab",
        "label": "TESTE METEREOLOGICO ",
        "disabled": false,
        "info": "",
        "env": []
    },
    {
        "id": "f1b2a111d2c12345",
        "type": "inject",
        "z": "72f12ba5c5367ee5",
        "name": "A cada 5 minutos",
        "props": [],
        "repeat": "300",
        "crontab": "",
        "once": true,
        "onceDelay": 0.1,
        "topic": "",
        "x": 310,
        "y": 280,
        "wires": [
            [
                "e2b3a222d2c12345"
            ]
        ]
    },
    {
        "id": "e2b3a222d2c12345",
        "type": "http request",
        "z": "72f12ba5c5367ee5",
        "name": "Pega dados da estação",
        "method": "GET",
        "ret": "obj",
        "paytoqs": "ignore",
        "url": "https://api.open-meteo.com/v1/forecast?latitude=-23.55&longitude=-46.63&current_weather=true",
        "tls": "",
        "persist": false,
        "proxy": "",
        "insecureHTTPParser": false,
        "authType": "",
        "senderr": false,
        "headers": [],
        "x": 540,
        "y": 280,
        "wires": [
            [
                "a3c4a333d2c12345"
            ]
        ]
    },
    {
        "id": "a3c4a333d2c12345",
        "type": "function",
        "z": "72f12ba5c5367ee5",
        "name": "Filtra dados",
        "func": "let clima = msg.payload.current_weather;\nmsg.payload = {\n    temperatura: clima.temperature,\n    vento: clima.windspeed,\n    direcao_vento: clima.winddirection,\n    hora: clima.time\n};\nreturn msg;",
        "outputs": 1,
        "timeout": "",
        "noerr": 0,
        "initialize": "",
        "finalize": "",
        "libs": [],
        "x": 590,
        "y": 540,
        "wires": [
            [
                "d4d5a444d2c12345",
                "b5e6a555d2c12345",
                "4b6fbb6e9f18e0d6",
                "a196feaf76ca97bf"
            ]
        ]
    },
    {
        "id": "d4d5a444d2c12345",
        "type": "debug",
        "z": "72f12ba5c5367ee5",
        "name": "Debug Dados",
        "active": true,
        "console": "false",
        "complete": "payload",
        "x": 990,
        "y": 240,
        "wires": []
    },
    {
        "id": "b5e6a555d2c12345",
        "type": "ui_gauge",
        "z": "72f12ba5c5367ee5",
        "tab": "",
        "name": "Temperatura",
        "group": "c6f7a666d2c12345",
        "order": 1,
        "format": "{{value}}",
        "min": "-10",
        "max": "50",
        "x": 1130,
        "y": 620,
        "wires": []
    },
    {
        "id": "4b6fbb6e9f18e0d6",
        "type": "ui-gauge",
        "z": "72f12ba5c5367ee5",
        "name": "",
        "group": "",
        "order": 3,
        "width": 3,
        "height": 3,
        "gtype": "gauge-half",
        "gstyle": "needle",
        "title": "gauge",
        "units": "units",
        "icon": "",
        "prefix": "",
        "suffix": "",
        "segments": [
            {
                "from": "0",
                "color": "#5cd65c"
            },
            {
                "from": "4",
                "color": "#ffc800"
            },
            {
                "from": "7",
                "color": "#ea5353"
            }
        ],
        "min": 0,
        "max": 10,
        "sizeThickness": 16,
        "sizeGap": 4,
        "sizeKeyThickness": 8,
        "styleRounded": true,
        "styleGlow": false,
        "className": "",
        "x": 1210,
        "y": 380,
        "wires": []
    },
    {
        "id": "a196feaf76ca97bf",
        "type": "switch",
        "z": "72f12ba5c5367ee5",
        "name": "",
        "property": "payload",
        "propertyType": "msg",
        "rules": [
            {
                "t": "eq",
                "v": "",
                "vt": "str"
            }
        ],
        "checkall": "true",
        "repair": false,
        "outputs": 1,
        "x": 670,
        "y": 660,
        "wires": [
            []
        ]
    },
    {
        "id": "inject_5min",
        "type": "inject",
        "z": "72f12ba5c5367ee5",
        "name": "A cada 5 min",
        "props": [],
        "repeat": "300",
        "once": true,
        "onceDelay": "0.1",
        "x": 190,
        "y": 900,
        "wires": [
            [
                "http_weather"
            ]
        ]
    },
    {
        "id": "http_weather",
        "type": "http request",
        "z": "72f12ba5c5367ee5",
        "name": "Pegar dados clima",
        "method": "GET",
        "ret": "obj",
        "paytoqs": "ignore",
        "url": "https://api.open-meteo.com/v1/forecast?latitude=-23.827528&longitude=-45.422359&current_weather=true",
        "tls": "",
        "persist": false,
        "proxy": "",
        "insecureHTTPParser": false,
        "authType": "",
        "senderr": false,
        "headers": [],
        "x": 400,
        "y": 900,
        "wires": [
            [
                "function_split"
            ]
        ]
    },
    {
        "id": "function_split",
        "type": "function",
        "z": "72f12ba5c5367ee5",
        "name": "Separar valores",
        "func": "let clima = msg.payload.current_weather;\n\nreturn [\n    { payload: clima.temperature, topic: \"temperatura\" },\n    { payload: clima.windspeed, topic: \"vento\" },\n    { payload: clima.winddirection, topic: \"direcao_vento\" },\n    { payload: clima.time, topic: \"hora\" }\n];",
        "outputs": 4,
        "timeout": "",
        "noerr": 0,
        "initialize": "",
        "finalize": "",
        "libs": [],
        "x": 620,
        "y": 900,
        "wires": [
            [
                "gauge_temp",
                "31cbb1999ef5ea34",
                "75c9535e6c4e8ac9"
            ],
            [
                "gauge_vento",
                "cb899f442401495b",
                "75c9535e6c4e8ac9"
            ],
            [
                "gauge_dir",
                "fc1ca4aa3828ce7c",
                "75c9535e6c4e8ac9"
            ],
            [
                "text_hora",
                "4281a7f702d45ca7",
                "75c9535e6c4e8ac9"
            ]
        ]
    },
    {
        "id": "gauge_temp",
        "type": "ui_gauge",
        "z": "72f12ba5c5367ee5",
        "tab": "",
        "name": "🌡️ Temperatura",
        "group": "ui_group_weather",
        "order": 1,
        "format": "{{value}}",
        "min": "-10",
        "max": "50",
        "x": 640,
        "y": 800,
        "wires": []
    },
    {
        "id": "gauge_vento",
        "type": "ui_gauge",
        "z": "72f12ba5c5367ee5",
        "tab": "",
        "name": "💨 Velocidade do Vento",
        "group": "ui_group_weather",
        "order": 2,
        "format": "{{value}}",
        "min": "0",
        "max": "100",
        "x": 930,
        "y": 1000,
        "wires": []
    },
    {
        "id": "gauge_dir",
        "type": "ui_gauge",
        "z": "72f12ba5c5367ee5",
        "tab": "",
        "name": "🧭 Direção do Vento",
        "group": "ui_group_weather",
        "order": 3,
        "format": "{{value}}",
        "min": "0",
        "max": "360",
        "x": 920,
        "y": 1080,
        "wires": []
    },
    {
        "id": "text_hora",
        "type": "ui_text",
        "z": "72f12ba5c5367ee5",
        "name": "🕒 Hora da leitura",
        "group": "ui_group_weather",
        "order": 4,
        "format": "{{msg.payload}}",
        "x": 810,
        "y": 1160,
        "wires": []
    },
    {
        "id": "31cbb1999ef5ea34",
        "type": "ui-gauge",
        "z": "72f12ba5c5367ee5",
        "name": "",
        "group": "017367f019459183",
        "order": 4,
        "width": 3,
        "height": 3,
        "gtype": "gauge-half",
        "gstyle": "needle",
        "title": "TEMPERATURA °C",
        "units": "°C",
        "icon": "",
        "prefix": "",
        "suffix": "",
        "segments": [
            {
                "from": "0",
                "color": "#5cd65c"
            },
            {
                "from": "4",
                "color": "#ffc800"
            },
            {
                "from": "7",
                "color": "#ea5353"
            }
        ],
        "min": 0,
        "max": 10,
        "sizeThickness": 16,
        "sizeGap": 4,
        "sizeKeyThickness": 8,
        "styleRounded": true,
        "styleGlow": false,
        "className": "",
        "x": 920,
        "y": 860,
        "wires": []
    },
    {
        "id": "cb899f442401495b",
        "type": "ui-gauge",
        "z": "72f12ba5c5367ee5",
        "name": "",
        "group": "017367f019459183",
        "order": 3,
        "width": 3,
        "height": 3,
        "gtype": "gauge-half",
        "gstyle": "needle",
        "title": "VELOCIDADE DE VENTO ",
        "units": "m/s",
        "icon": "",
        "prefix": "",
        "suffix": "",
        "segments": [
            {
                "from": "0",
                "color": "#5cd65c"
            },
            {
                "from": "4",
                "color": "#ffc800"
            },
            {
                "from": "7",
                "color": "#ea5353"
            }
        ],
        "min": 0,
        "max": "100",
        "sizeThickness": 16,
        "sizeGap": 4,
        "sizeKeyThickness": 8,
        "styleRounded": true,
        "styleGlow": false,
        "className": "",
        "x": 940,
        "y": 940,
        "wires": []
    },
    {
        "id": "b1016fab2e916966",
        "type": "inject",
        "z": "72f12ba5c5367ee5",
        "name": "A cada 5 min",
        "props": [],
        "repeat": "300",
        "once": true,
        "onceDelay": "0.1",
        "x": 340,
        "y": 1460,
        "wires": [
            [
                "21d4f93974a85dd4"
            ]
        ]
    },
    {
        "id": "21d4f93974a85dd4",
        "type": "http request",
        "z": "72f12ba5c5367ee5",
        "name": "Pegar dados clima",
        "method": "GET",
        "ret": "obj",
        "paytoqs": "ignore",
        "url": "https://api.open-meteo.com/v1/forecast?latitude=-23.827528&longitude=-45.422359&current_weather=true",
        "tls": "",
        "persist": false,
        "proxy": "",
        "insecureHTTPParser": false,
        "authType": "",
        "senderr": false,
        "headers": [],
        "x": 730,
        "y": 1500,
        "wires": [
            [
                "d1f3d323b96c2890",
                "e0e5901b8c887916"
            ]
        ]
    },
    {
        "id": "d1f3d323b96c2890",
        "type": "function",
        "z": "72f12ba5c5367ee5",
        "name": "Separar valores",
        "func": "let clima = msg.payload.current_weather;\n\nreturn [\n    { payload: clima.temperature, topic: \"temperatura\" },\n    { payload: clima.windspeed, topic: \"vento\" },\n    { payload: clima.winddirection, topic: \"direcao_vento\" },\n    { payload: clima.time, topic: \"hora\" }\n];",
        "outputs": 4,
        "noerr": 0,
        "x": 1080,
        "y": 1620,
        "wires": [
            [],
            [],
            [],
            []
        ]
    },
    {
        "id": "e0e5901b8c887916",
        "type": "function",
        "z": "72f12ba5c5367ee5",
        "name": "Formatar JSON PowerBI",
        "func": "let clima = msg.payload.current_weather;\n\nmsg.payload = [\n    {\n        hora: clima.time,\n        temperatura: clima.temperature,\n        vento: clima.windspeed,\n        direcao_vento: clima.winddirection\n    }\n];\n\nreturn msg;",
        "outputs": 1,
        "noerr": 0,
        "x": 830,
        "y": 1340,
        "wires": [
            [
                "55306382775c352d"
            ]
        ]
    },
    {
        "id": "55306382775c352d",
        "type": "http request",
        "z": "72f12ba5c5367ee5",
        "name": "Enviar PowerBI",
        "method": "POST",
        "ret": "obj",
        "paytoqs": "ignore",
        "url": "COLE_AQUI_URL_DO_POWERBI",
        "tls": "",
        "persist": false,
        "proxy": "",
        "insecureHTTPParser": false,
        "authType": "",
        "senderr": false,
        "headers": [
            {
                "key": "Content-Type",
                "value": "application/json"
            }
        ],
        "x": 1100,
        "y": 1440,
        "wires": [
            []
        ]
    },
    {
        "id": "fc1ca4aa3828ce7c",
        "type": "ui-gauge",
        "z": "72f12ba5c5367ee5",
        "name": "DIREÇÃO DO VENTO",
        "group": "017367f019459183",
        "order": 2,
        "width": 3,
        "height": 3,
        "gtype": "gauge-half",
        "gstyle": "needle",
        "title": "DIREÇÃO DO VENTO",
        "units": "° GRAUS",
        "icon": "",
        "prefix": "",
        "suffix": "",
        "segments": [
            {
                "from": "0",
                "color": "#5cd65c"
            },
            {
                "from": "4",
                "color": "#ffc800"
            },
            {
                "from": "7",
                "color": "#ea5353"
            }
        ],
        "min": 0,
        "max": "360",
        "sizeThickness": 16,
        "sizeGap": 4,
        "sizeKeyThickness": 8,
        "styleRounded": true,
        "styleGlow": false,
        "className": "",
        "x": 1200,
        "y": 1100,
        "wires": []
    },
    {
        "id": "4281a7f702d45ca7",
        "type": "ui-text",
        "z": "72f12ba5c5367ee5",
        "group": "017367f019459183",
        "order": 1,
        "width": 0,
        "height": 0,
        "name": "",
        "label": "TIMESTAMP - DADOS EM TEMPO REAL ",
        "format": "{{msg.payload}}",
        "layout": "row-spread",
        "style": false,
        "font": "",
        "fontSize": 16,
        "color": "#717171",
        "wrapText": false,
        "className": "",
        "x": 980,
        "y": 1220,
        "wires": []
    },
    {
        "id": "6f6f5731c1c1d823",
        "type": "inject",
        "z": "72f12ba5c5367ee5",
        "name": "A cada 5 min",
        "props": [],
        "repeat": "300",
        "once": true,
        "onceDelay": "0.1",
        "x": 240,
        "y": 2120,
        "wires": [
            [
                "47be9115c10611d2"
            ]
        ]
    },
    {
        "id": "47be9115c10611d2",
        "type": "http request",
        "z": "72f12ba5c5367ee5",
        "name": "Pegar dados clima",
        "method": "GET",
        "ret": "obj",
        "paytoqs": "ignore",
        "url": "https://api.open-meteo.com/v1/forecast?latitude=-23.827528&longitude=-45.422359&current_weather=true",
        "tls": "",
        "persist": false,
        "proxy": "",
        "insecureHTTPParser": false,
        "authType": "",
        "senderr": false,
        "headers": [],
        "x": 460,
        "y": 2120,
        "wires": [
            [
                "feec38abb418db31"
            ]
        ]
    },
    {
        "id": "feec38abb418db31",
        "type": "function",
        "z": "72f12ba5c5367ee5",
        "name": "Formatar JSON WebSocket",
        "func": "let clima = msg.payload.current_weather;\nmsg.payload = {\n    hora: clima.time,\n    temperatura: clima.temperature,\n    vento: clima.windspeed,\n    direcao_vento: clima.winddirection\n};\nreturn msg;",
        "outputs": 1,
        "x": 710,
        "y": 2120,
        "wires": [
            [
                "0631831912411620"
            ]
        ]
    },
    {
        "id": "0631831912411620",
        "type": "websocket out",
        "z": "72f12ba5c5367ee5",
        "name": "Enviar para WebSocket",
        "server": "",
        "client": "88aae4cec1fbdd01",
        "x": 960,
        "y": 2120,
        "wires": []
    },
    {
        "id": "38cc726db80ecc1e",
        "type": "http in",
        "z": "72f12ba5c5367ee5",
        "name": "Página Clima",
        "url": "/clima",
        "method": "get",
        "upload": false,
        "swaggerDoc": "",
        "x": 220,
        "y": 2220,
        "wires": [
            [
                "c76d0965d833010b"
            ]
        ]
    },
    {
        "id": "c76d0965d833010b",
        "type": "function",
        "z": "72f12ba5c5367ee5",
        "name": "Enviar HTML",
        "func": "msg.headers = { 'Content-Type':'text/html' };\nmsg.payload = `\n<!DOCTYPE html>\n<html lang=\"pt-BR\">\n<head>\n<meta charset=\"UTF-8\">\n<title>Clima em Tempo Real</title>\n<style>\nbody { font-family: Arial; background:#111; color:#fff; text-align:center; }\n.card { background:#222; padding:20px; margin:20px; border-radius:12px; display:inline-block; width:200px; }\nh2 { margin:10px 0; }\n</style>\n</head>\n<body>\n<h1>🌤️ Clima Tempo Real - Praia do Segredo</h1>\n<div class=\"card\"><h2>🌡️ Temperatura</h2><p id=\"temp\">-- °C</p></div>\n<div class=\"card\"><h2>💨 Vento</h2><p id=\"vento\">-- m/s</p></div>\n<div class=\"card\"><h2>🧭 Direção</h2><p id=\"dir\">-- °</p></div>\n<div class=\"card\"><h2>🕒 Hora</h2><p id=\"hora\">--</p></div>\n<script>\nconst ws = new WebSocket(\"ws://\" + location.host + \"/ws/clima\");\nws.onmessage = (event) => {\n  const data = JSON.parse(event.data);\n  document.getElementById(\"temp\").textContent = data.temperatura + \" °C\";\n  document.getElementById(\"vento\").textContent = data.vento + \" m/s\";\n  document.getElementById(\"dir\").textContent = data.direcao_vento + \" °\";\n  document.getElementById(\"hora\").textContent = data.hora;\n};\n</script>\n</body>\n</html>\n`;\nreturn msg;",
        "outputs": 1,
        "timeout": "",
        "noerr": 0,
        "initialize": "",
        "finalize": "",
        "libs": [],
        "x": 460,
        "y": 2220,
        "wires": [
            [
                "acaf2018634de990"
            ]
        ]
    },
    {
        "id": "acaf2018634de990",
        "type": "http response",
        "z": "72f12ba5c5367ee5",
        "name": "",
        "statusCode": "",
        "headers": {},
        "x": 710,
        "y": 2220,
        "wires": []
    },
    {
        "id": "1c57a9b318f8ccbd",
        "type": "ui-template",
        "z": "72f12ba5c5367ee5",
        "group": "017367f019459183",
        "page": "",
        "ui": "",
        "name": "",
        "order": 5,
        "width": 0,
        "height": 0,
        "head": "",
        "format": "<!DOCTYPE html>\n<html lang=\"pt-BR\">\n\n<head>\n    <meta charset=\"UTF-8\">\n    <title>Clima em Tempo Real</title>\n    <script src=\"https://cdn.plot.ly/plotly-latest.min.js\"></script>\n    <style>\n        body {\n            font-family: Arial;\n            background: #111;\n            color: #fff;\n            text-align: center;\n        }\n\n        .card {\n            background: #222;\n            padding: 20px;\n            margin: 20px;\n            border-radius: 12px;\n            display: inline-block;\n            width: 200px;\n        }\n\n        h2 {\n            margin: 10px 0;\n        }\n\n        #plot {\n            width: 90%;\n            max-width: 800px;\n            margin: 40px auto;\n        }\n    </style>\n</head>\n\n<body>\n    <h1>🌤️ Clima Tempo Real - Praia do Segredo</h1>\n\n    <div class=\"card\">\n        <h2>🌡️ Temperatura</h2>\n        <p id=\"temp\">-- °C</p>\n    </div>\n    <div class=\"card\">\n        <h2>💨 Vento</h2>\n        <p id=\"vento\">-- m/s</p>\n    </div>\n    <div class=\"card\">\n        <h2>🧭 Direção</h2>\n        <p id=\"dir\">-- °</p>\n    </div>\n    <div class=\"card\">\n        <h2>🕒 Hora</h2>\n        <p id=\"hora\">--</p>\n    </div>\n\n    <div id=\"plot\"></div>\n\n    <script>\n        let times = [];\n        let temperatures = [];\n        let lastData = null;\n\n        // Inicializa o gráfico Plotly do tipo barra (Pareto)\n        Plotly.newPlot('plot', [{\n            x: times,\n            y: temperatures,\n            type: 'bar',\n            name: 'Temperatura (°C)',\n            marker: { color: '#ff9900' }\n        }, {\n            x: times,\n            y: [],\n            type: 'scatter',\n            mode: 'lines+markers',\n            name: 'Percentual Acumulado',\n            yaxis: 'y2',\n            line: { color: '#00ccff' }\n        }], {\n            title: 'Temperatura em Tempo Real (Pareto)',\n            plot_bgcolor: \"#111\",\n            paper_bgcolor: \"#111\",\n            font: { color: \"#fff\" },\n            xaxis: { title: \"Hora\" },\n            yaxis: { title: \"°C\", range: [-10, 50] },\n            yaxis2: {\n                title: \"Percentual Acumulado\",\n                overlaying: 'y',\n                side: 'right',\n                range: [0, 100],\n                showgrid: false\n            }\n        });\n\n        // Conecta ao WebSocket do Node-RED\n        const ws = new WebSocket(\"ws://localhost:1880/ws/clima\");\n\n        ws.onmessage = (event) => {\n            const data = JSON.parse(event.data);\n\n            // Atualiza os cards em tempo real\n            document.getElementById(\"temp\").textContent = data.temperatura + \" °C\";\n            document.getElementById(\"vento\").textContent = data.vento + \" m/s\";\n            document.getElementById(\"dir\").textContent = data.direcao_vento + \" °\";\n            document.getElementById(\"hora\").textContent = data.hora;\n\n            // Armazena o último dado recebido\n            lastData = data;\n        };\n\n        // Atualiza o gráfico a cada 30 segundos\n        setInterval(() => {\n            if (lastData) {\n                times.push(lastData.hora);\n                temperatures.push(lastData.temperatura);\n\n                if (times.length > 1) {\n                    times.shift();\n                    temperatures.shift();\n                }\n\n                // Calcula percentual acumulado para o Pareto\n                let total = temperatures.reduce((a, b) => a + b, 0);\n                let accumulated = [];\n                let sum = 0;\n                for (let t of temperatures) {\n                    sum += t;\n                    accumulated.push((sum / total) * 100);\n                }\n\n                Plotly.update('plot', {\n                    x: [times, times],\n                    y: [temperatures, accumulated]\n                });\n            }\n        }, 3000); // 30 segundos\n    </script>\n</body>\n\n</html>\n",
        "storeOutMessages": true,
        "passthru": true,
        "resendOnRefresh": true,
        "templateScope": "local",
        "className": "",
        "x": 980,
        "y": 2260,
        "wires": [
            []
        ]
    },
    {
        "id": "d8c3e6e6ef26b5b6",
        "type": "ui-template",
        "z": "72f12ba5c5367ee5",
        "group": "",
        "page": "",
        "ui": "",
        "name": "",
        "order": 1,
        "width": 0,
        "height": 0,
        "head": "",
        "format": "<!DOCTYPE html>\n<html lang=\"pt-BR\">\n\n<head>\n    <meta charset=\"UTF-8\">\n    <title>Clima em Tempo Real</title>\n    <script src=\"https://cdn.plot.ly/plotly-latest.min.js\"></script>\n    <style>\n        body {\n            font-family: Arial;\n            background: #111;\n            color: #fff;\n            text-align: center;\n        }\n\n        .card {\n            background: #222;\n            padding: 20px;\n            margin: 20px;\n            border-radius: 12px;\n            display: inline-block;\n            width: 200px;\n        }\n\n        h2 {\n            margin: 10px 0;\n        }\n\n        #plot {\n            width: 90%;\n            max-width: 800px;\n            margin: 40px auto;\n        }\n    </style>\n</head>\n\n<body>\n    <h1>🌤️ Clima Tempo Real - Praia do Segredo</h1>\n\n    <div class=\"card\">\n        <h2>🌡️ Temperatura</h2>\n        <p id=\"temp\">-- °C</p>\n    </div>\n    <div class=\"card\">\n        <h2>💨 Vento</h2>\n        <p id=\"vento\">-- m/s</p>\n    </div>\n    <div class=\"card\">\n        <h2>🧭 Direção</h2>\n        <p id=\"dir\">-- °</p>\n    </div>\n    <div class=\"card\">\n        <h2>🕒 Hora</h2>\n        <p id=\"hora\">--</p>\n    </div>\n\n    <div id=\"plot\"></div>\n\n    <script>\n        // Arrays para armazenar os dados do gráfico\n        let times = [];\n        let temperatures = [];\n\n        // Inicializa o gráfico Plotly\n        Plotly.newPlot('plot', [{\n            x: times,\n            y: temperatures,\n            mode: 'lines+markers',\n            line: { color: '#ff9900' },\n            name: 'Temperatura (°C)'\n        }], {\n            title: 'Temperatura em Tempo Real',\n            plot_bgcolor: \"#111\",\n            paper_bgcolor: \"#111\",\n            font: { color: \"#fff\" },\n            xaxis: { title: \"Hora\" },\n            yaxis: { title: \"°C\", range: [-10, 50] }\n        });\n\n        // Conecta ao WebSocket do Node-RED\n        const ws = new WebSocket(\"ws://localhost:1880/ws/clima\");\n\n        ws.onmessage = (event) => {\n            const data = JSON.parse(event.data);\n\n            // Atualiza os cards\n            document.getElementById(\"temp\").textContent = data.temperatura + \" °C\";\n            document.getElementById(\"vento\").textContent = data.vento + \" m/s\";\n            document.getElementById(\"dir\").textContent = data.direcao_vento + \" °\";\n            document.getElementById(\"hora\").textContent = data.hora;\n\n            // Atualiza arrays para gráfico\n            times.push(data.hora);\n            temperatures.push(data.temperatura);\n\n            // Mantém apenas os últimos 20 pontos\n            if (times.length > 20) {\n                times.shift();\n                temperatures.shift();\n            }\n\n            // Atualiza o gráfico\n            Plotly.update('plot', {\n                x: [times],\n                y: [temperatures]\n            });\n        };\n    </script>\n</body>\n\n</html>\n",
        "storeOutMessages": true,
        "passthru": true,
        "resendOnRefresh": true,
        "templateScope": "local",
        "className": "",
        "x": 1440,
        "y": 2280,
        "wires": [
            []
        ]
    },
    {
        "id": "21b6c150b5f36acf",
        "type": "inject",
        "z": "72f12ba5c5367ee5",
        "name": "A cada 5 min",
        "props": [],
        "repeat": "300",
        "once": true,
        "onceDelay": "0.1",
        "x": 320,
        "y": 2480,
        "wires": [
            [
                "2a88b46f5231859a"
            ]
        ]
    },
    {
        "id": "2a88b46f5231859a",
        "type": "http request",
        "z": "72f12ba5c5367ee5",
        "name": "Pegar dados clima",
        "method": "GET",
        "ret": "obj",
        "url": "https://api.open-meteo.com/v1/forecast?latitude=-23.827528&longitude=-45.422359&current_weather=true",
        "x": 540,
        "y": 2480,
        "wires": [
            [
                "b91a8f513e8ed5f5"
            ]
        ]
    },
    {
        "id": "b91a8f513e8ed5f5",
        "type": "function",
        "z": "72f12ba5c5367ee5",
        "name": "Formatar JSON WebSocket",
        "func": "let clima = msg.payload.current_weather;\nmsg.payload = {\n    hora: clima.time,\n    temperatura: clima.temperature,\n    vento: clima.windspeed,\n    direcao_vento: clima.winddirection\n};\nreturn msg;",
        "outputs": 1,
        "x": 790,
        "y": 2480,
        "wires": [
            [
                "931fb1bbc73a8d30"
            ]
        ]
    },
    {
        "id": "931fb1bbc73a8d30",
        "type": "websocket out",
        "z": "72f12ba5c5367ee5",
        "name": "Enviar para WebSocket",
        "client": "6bfc6b7c18ff25d1",
        "x": 1040,
        "y": 2480,
        "wires": []
    },
    {
        "id": "3ce0f95e96c859e4",
        "type": "http in",
        "z": "72f12ba5c5367ee5",
        "name": "Página Clima",
        "url": "/clima",
        "method": "get",
        "x": 300,
        "y": 2580,
        "wires": [
            [
                "fce68f11a4f676e1"
            ]
        ]
    },
    {
        "id": "fce68f11a4f676e1",
        "type": "function",
        "z": "72f12ba5c5367ee5",
        "name": "Enviar HTML",
        "func": "msg.headers = { 'Content-Type':'text/html' };\nmsg.payload = `<!DOCTYPE html>\n<html lang='pt-BR'>\n<head>\n<meta charset='UTF-8'>\n<title>Clima em Tempo Real</title>\n<script src='https://cdn.plot.ly/plotly-latest.min.js'></script>\n<style>\nbody { font-family: Arial; background:#111; color:#fff; text-align:center; }\n.card { background:#222; padding:20px; margin:20px; border-radius:12px; display:inline-block; width:200px; }\nh2 { margin:10px 0; }\n#plot { width:90%; max-width:800px; margin:40px auto; }\n</style>\n</head>\n<body>\n<h1>🌤️ Clima Tempo Real - Praia do Segredo</h1>\n<div class='card'><h2>🌡️ Temperatura</h2><p id='temp'>-- °C</p></div>\n<div class='card'><h2>💨 Vento</h2><p id='vento'>-- m/s</p></div>\n<div class='card'><h2>🧭 Direção</h2><p id='dir'>-- °</p></div>\n<div class='card'><h2>🕒 Hora</h2><p id='hora'>--</p></div>\n<div id='plot'></div>\n<script>\nlet times = [], temperatures = [];\nPlotly.newPlot('plot', [{ x: times, y: temperatures, mode:'lines+markers', line:{color:'#ff9900'}, name:'Temperatura (°C)' }], {title:'Temperatura em Tempo Real', plot_bgcolor:'#111', paper_bgcolor:'#111', font:{color:'#fff'}, xaxis:{title:'Hora'}, yaxis:{title:'°C', range:[-10,50]}});\nconst ws = new WebSocket('ws://'+location.host+'/ws/clima');\nws.onmessage = (event) => {\n  const data = JSON.parse(event.data);\n  document.getElementById('temp').textContent = data.temperatura + ' °C';\n  document.getElementById('vento').textContent = data.vento + ' m/s';\n  document.getElementById('dir').textContent = data.direcao_vento + ' °';\n  document.getElementById('hora').textContent = data.hora;\n  times.push(data.hora); temperatures.push(data.temperatura);\n  if(times.length>20){times.shift(); temperatures.shift();}\n  Plotly.update('plot',{x:[times],y:[temperatures]});\n};\n</script>\n</body>\n</html>`;\nreturn msg;",
        "outputs": 1,
        "x": 540,
        "y": 2580,
        "wires": [
            [
                "cfbdd7f36b1d569a"
            ]
        ]
    },
    {
        "id": "cfbdd7f36b1d569a",
        "type": "http response",
        "z": "72f12ba5c5367ee5",
        "name": "",
        "statusCode": "",
        "x": 790,
        "y": 2580,
        "wires": []
    },
    {
        "id": "6baa8210973f86af",
        "type": "ui-template",
        "z": "72f12ba5c5367ee5",
        "group": "2c4659d9bf7f086a",
        "page": "",
        "ui": "",
        "name": "",
        "order": 1,
        "width": 0,
        "height": 0,
        "head": "",
        "format": "<!DOCTYPE html>\n<html lang=\"pt-BR\">\n<head>\n    <meta charset=\"UTF-8\">\n    <title>Mapa CEBIMar</title>\n    <script src=\"https://cdn.plot.ly/plotly-latest.min.js\"></script>\n    <style>\n        body { font-family: Arial; background: #111; color: #fff; text-align: center; }\n        #map { width: 90%; height: 500px; margin: 20px auto; border-radius: 12px; overflow: hidden; }\n        #gif3d {\n            width: 400px; max-width: 90%;\n            margin: 20px auto;\n            border-radius: 12px;\n            box-shadow: 0 0 20px rgba(255, 153, 0, 0.7);\n        }\n        button {\n            background-color: #ff9900; border: none; color: #111;\n            padding: 10px 20px; font-size: 16px; border-radius: 8px;\n            cursor: pointer; margin-top: 20px;\n        }\n        button:hover { background-color: #ffaa33; }\n    </style>\n</head>\n<body>\n    <h1>🗺️ Mapa CEBIMar - Praia do Segredo</h1>\n\n    <!-- GIF animado em 3D (exemplo funcional) -->\n    <img id=\"gif3d\" src=\"https://s3.amazonaws.com/cdn.chickenorpasta.com.br/content/uploads/2019/05/13181027/pluvion1.gif\" alt=\"São Sebastião 3D animado\">\n\n    <div id=\"map\"></div>\n    <button id=\"infoBtn\">ℹ️ Informações sobre Vida Marinha</button>\n\n    <script>\n        const cebimar = { lat: -23.828, lon: -45.422 };\n        Plotly.newPlot('map', [{\n            type: 'scattermapbox',\n            lat: [cebimar.lat], lon: [cebimar.lon],\n            mode: 'markers',\n            marker: { size: 14, color: '#ff9900' },\n            text: ['CEBIMar - Praia do Segredo'],\n            hoverinfo: 'text'\n        }], {\n            mapbox: {\n                style: 'open-street-map',\n                center: { lat: cebimar.lat, lon: cebimar.lon },\n                zoom: 12\n            },\n            margin: { t: 0, b: 0, l: 0, r: 0 }\n        });\n        document.getElementById(\"infoBtn\").addEventListener(\"click\", () => {\n            alert(\"🐟 Vida Marinha em Praia do Segredo:\\n\\n- Peixes tropicais\\n- Corais\\n- Tartarugas marinhas\\n- Estrelas-do-mar\");\n        });\n    </script>\n</body>\n</html>\n",
        "storeOutMessages": true,
        "passthru": true,
        "resendOnRefresh": true,
        "templateScope": "local",
        "className": "",
        "x": 940,
        "y": 2740,
        "wires": [
            []
        ]
    },
    {
        "id": "75c9535e6c4e8ac9",
        "type": "ui-chart",
        "z": "72f12ba5c5367ee5",
        "group": "2c4659d9bf7f086a",
        "name": "",
        "label": "chart",
        "order": 2,
        "chartType": "line",
        "category": "topic",
        "categoryType": "msg",
        "xAxisLabel": "",
        "xAxisProperty": "",
        "xAxisPropertyType": "timestamp",
        "xAxisType": "time",
        "xAxisFormat": "",
        "xAxisFormatType": "auto",
        "xmin": "",
        "xmax": "",
        "yAxisLabel": "",
        "yAxisProperty": "payload",
        "yAxisPropertyType": "msg",
        "ymin": "",
        "ymax": "",
        "bins": 10,
        "action": "append",
        "stackSeries": false,
        "pointShape": "circle",
        "pointRadius": 4,
        "showLegend": true,
        "removeOlder": 1,
        "removeOlderUnit": "3600",
        "removeOlderPoints": "",
        "colors": [
            "#0095ff",
            "#ff0000",
            "#ff7f0e",
            "#2ca02c",
            "#a347e1",
            "#d62728",
            "#ff9896",
            "#9467bd",
            "#c5b0d5"
        ],
        "textColor": [
            "#666666"
        ],
        "textColorDefault": true,
        "gridColor": [
            "#e5e5e5"
        ],
        "gridColorDefault": true,
        "width": 6,
        "height": 8,
        "className": "",
        "interpolation": "linear",
        "x": 1390,
        "y": 860,
        "wires": [
            []
        ]
    },
    {
        "id": "017367f019459183",
        "type": "ui-group",
        "name": "METEREOLOGICO PRAIA DO SEGREDO CEBIMAR",
        "page": "cdeaa4bbc0a7528c",
        "width": 6,
        "height": 1,
        "order": 1,
        "showTitle": true,
        "className": "",
        "visible": "true",
        "disabled": "false",
        "groupType": "default"
    },
    {
        "id": "88aae4cec1fbdd01",
        "type": "websocket-client",
        "path": "/ws/clima",
        "wholemsg": "false"
    },
    {
        "id": "6bfc6b7c18ff25d1",
        "type": "websocket-client",
        "path": "/ws/clima",
        "wholemsg": "false"
    },
    {
        "id": "2c4659d9bf7f086a",
        "type": "ui-group",
        "name": "MAPA PRAIA DO SEGREDO CEBIMAR",
        "page": "cdeaa4bbc0a7528c",
        "width": 6,
        "height": 1,
        "order": 2,
        "showTitle": true,
        "className": "",
        "visible": "true",
        "disabled": "false",
        "groupType": "default"
    },
    {
        "id": "cdeaa4bbc0a7528c",
        "type": "ui-page",
        "name": "METEREOLOGICO",
        "ui": "8811a3135308c3ce",
        "path": "/METEREOLOGICO",
        "icon": "home",
        "layout": "grid",
        "theme": "6330ea80a04b407c",
        "breakpoints": [
            {
                "name": "Default",
                "px": "0",
                "cols": "3"
            },
            {
                "name": "Tablet",
                "px": "576",
                "cols": "6"
            },
            {
                "name": "Small Desktop",
                "px": "768",
                "cols": "9"
            },
            {
                "name": "Desktop",
                "px": "1024",
                "cols": "12"
            }
        ],
        "order": 7,
        "className": "",
        "visible": true,
        "disabled": false
    },
    {
        "id": "8811a3135308c3ce",
        "type": "ui-base",
        "name": "My Dashboard",
        "path": "/dashboard",
        "appIcon": "",
        "includeClientData": true,
        "acceptsClientConfig": [
            "ui-notification",
            "ui-control"
        ],
        "showPathInSidebar": false,
        "headerContent": "page",
        "navigationStyle": "default",
        "titleBarStyle": "default",
        "showReconnectNotification": true,
        "notificationDisplayTime": 1,
        "showDisconnectNotification": true
    },
    {
        "id": "6330ea80a04b407c",
        "type": "ui-theme",
        "name": "Default Theme",
        "colors": {
            "surface": "#121111",
            "primary": "#0094ce",
            "bgPage": "#121111",
            "groupBg": "#1a1a1a",
            "groupOutline": "#cccccc"
        },
        "sizes": {
            "density": "default",
            "pagePadding": "12px",
            "groupGap": "12px",
            "groupBorderRadius": "4px",
            "widgetGap": "12px"
        }
    }
]
