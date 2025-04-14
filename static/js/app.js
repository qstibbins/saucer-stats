// Creating the map object
let myMap = L.map("map", {
  center: [39.5, -98.35],
  zoom: 3
});

// Adding the street tile layer
let streetmap = L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
  attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
});

// Adding the street map layer to the map
//streetmap.addTo(myMap);

// Adding NASA Blue Marble Tile Layer
let nasaMap = L.tileLayer("https://gibs.earthdata.nasa.gov/wmts/epsg3857/best/BlueMarble_NextGeneration/default/2024-01-01/GoogleMapsCompatible_Level8/{z}/{y}/{x}.jpg",
  {
    attribution: "NASA Blue Marble - GIBS",
    tileSize: 256,
    minZoom: 1, 
    maxZoom: 8,
    noWrap: true
  }
);

// Adding NASA Earth at Night layer
let nightMap = L.tileLayer(  "https://gibs.earthdata.nasa.gov/wmts/epsg3857/best/VIIRS_CityLights_2012/default/2012-01-01/GoogleMapsCompatible_Level8/{z}/{y}/{x}.jpg",
  {
    attribution: "NASA Earth At Night", 
    tileSize: 256,
    miniZoom: 1,
    maxZoom: 8,
    noWrap: true
  }
);

// Adding Dark Matter layer
let darkMap = L.tileLayer (
  "https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png",
  {
    attribution: '&copy; <a href="https://carto.com/">CARTO</a>',
    subdomains: "abcd", 
    maxZoom: 19
  }
);
darkMap.addTo(myMap);

// Add layer control
let baseMaps = {
  "NASA Blue Marble": nasaMap,
  "Street Map": streetmap,
  "Night Lights": nightMap,
  "Dark Matter": darkMap
};

L.control.layers(baseMaps, null,{
  collapsed: false
}).addTo(myMap);

//UFO shapes
let shapes = ['changing', 'light', 'orb', 'formation', 'circle', 'diamond', 'egg', 'oval', 'other',
  'disk', 'triangle', 'cigar', 'fireball', 'chevron', 'cylinder', 'star', 'sphere', 'unknown', 
  'cube', 'rectangle']

function getShapeIcon(shape) {
  let shapeLower = shape.toLowerCase(); 
  let emoji = "🛸";

  if (shapeLower === 'changing') emoji = '🌈';
  else if (shapeLower === 'light') emoji = '✨';
  else if (shapeLower === 'orb') emoji = '🔮';
  else if (shapeLower === 'formation') emoji = '🧿';
  else if (shapeLower === 'circle') emoji = '⭕️';
  else if (shapeLower === 'diamond') emoji = '💎';
  else if (shapeLower === 'egg') emoji = '🥚';
  else if (shapeLower === 'oval') emoji = '🥚';
  else if (shapeLower === 'other') emoji = '❔';
  else if (shapeLower === 'disk') emoji = '🛸';
  else if (shapeLower === 'triangle') emoji = '🔺';
  else if (shapeLower === 'cigar') emoji = '🚬';
  else if (shapeLower === 'fireball') emoji = '🔥';
  else if (shapeLower === 'chevron') emoji = '🔷';
  else if (shapeLower === 'cylinder') emoji = '🧪';
  else if (shapeLower === 'star') emoji = '🌟';
  else if (shapeLower === 'sphere') emoji = '🟢';
  else if (shapeLower === 'unknown') emoji = '👻';
  else if (shapeLower === 'cube') emoji = '🧊';
  else if (shapeLower === 'rectangle') emoji = '🟩';

  return L.divIcon({
    className: 'custom-icon', 
    html: `<div style="font-size: 24px;">${emoji}</div>`,
    iconSize: [30,30], 
    iconAnchor: [15,15],
  });
}

// Marker logic
const allMarkers = [];
let currentShape = "all";

const shapeSelect = document.getElementById("shapeFilter");
shapes.forEach(shape => {
  const option = document.createElement("option");
  option.value = shape;
  option.textContent = shape.charAt(0).toUpperCase() + shape.slice(1);
  shapeSelect.appendChild(option);
});

shapeSelect.addEventListener("change", () => {
  currentShape = shapeSelect.value;
  updateMarkers();
});

function updateMarkers() {
  allMarkers.forEach(({ marker, shape }) => {
    if (currentShape === "all" || shape === currentShape) {
      marker.addTo(myMap);
    } else {
      myMap.removeLayer(marker);
    }
  });
}

// Load the CSV file using PapaParse
Papa.parse('https://raw.githubusercontent.com/qstibbins/saucer-stats/refs/heads/main/data/small_dataset_with_coords.csv', {
  download: true,
  header: true,
  complete: function(results) {
    results.data.forEach(row => {
      const ufoShape = row["UFO Shape"];
      const lat = parseFloat(row.latitude);
      const lon = parseFloat(row.longitude);
      const shapeLower = ufoShape.toLowerCase();

      if (!isNaN(lat) && !isNaN(lon) && shapes.includes(shapeLower)) {
        const icon = getShapeIcon(ufoShape);
        const marker = L.marker([lat, lon], {icon});
      

          // Create a popup with the detailed information
          const popupContent = `
            <strong><a href="${row["Report Link"]}" target="_blank">Report Link</a></strong><br>
            <strong>Sighting Date:</strong> ${row["Sighting DateTime"]}<br>
            <strong>Location: </strong> ${row["City"]}, ${row["State Province"]}, ${row["Country"]}<br>
            <strong>UFO Shape:</strong> ${ufoShape}<br>
            <strong>Summary:</strong> ${row["Report Summary"]}<br>
            <strong>Media:</strong> ${row["Media"]}<br>
            <strong>Explanation:</strong> ${row["Explanation"]}
          `;

          marker.bindPopup(popupContent);
          allMarkers.push({marker, shape:shapeLower});

          // Add marker to the map
          //marker.addTo(myMap); 
        }
      });
      updateMarkers();
    },
  });