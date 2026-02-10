function mappa_globale
f = figure('Position', [100, 100, 1400, 800]);

% Solo pannelli input all'avvio
panel_top = uipanel('Parent', f, 'Title', 'INTERCETTORE', 'FontSize', 11, ...
	'BackgroundColor', [0.95 0.95 0.95], 'Position', [0.05 0.85 0.6 0.13]);
uicontrol('Parent', panel_top, 'Style', 'text', 'String', 'Latitudine:', 'Units', 'normalized', 'Position', [0.05 0.7 0.22 0.2], 'FontSize', 11, 'BackgroundColor', [0.95 0.95 0.95]);
lat_intc_edit = uicontrol('Parent', panel_top, 'Style', 'edit', 'String', '', 'Units', 'normalized', 'Position', [0.21 0.7 0.15 0.2], 'FontSize', 11);
uicontrol('Parent', panel_top, 'Style', 'text', 'String', 'Longitudine:', 'Units', 'normalized', 'Position', [0.38 0.7 0.22 0.2], 'FontSize', 11, 'BackgroundColor', [0.95 0.95 0.95]);
lon_intc_edit = uicontrol('Parent', panel_top, 'Style', 'edit', 'String', '', 'Units', 'normalized', 'Position', [0.54 0.7 0.15 0.2], 'FontSize', 11);
uicontrol('Parent', panel_top, 'Style', 'text', 'String', 'Velocità (kts):', 'Units', 'normalized', 'Position', [0.05 0.4 0.22 0.2], 'FontSize', 11, 'BackgroundColor', [0.95 0.95 0.95]);
vel_intc_edit = uicontrol('Parent', panel_top, 'Style', 'edit', 'String', '', 'Units', 'normalized', 'Position', [0.21 0.4 0.15 0.2], 'FontSize', 11);

panel_bottom = uipanel('Parent', f, 'Title', 'NAVE DA INTERCETTARE', 'FontSize', 11, ...
	'BackgroundColor', [0.95 0.95 0.95], 'Position', [0.05 0.7 0.6 0.13]);
uicontrol('Parent', panel_bottom, 'Style', 'text', 'String', 'Latitudine:', 'Units', 'normalized', 'Position', [0.05 0.7 0.22 0.2], 'FontSize', 11, 'BackgroundColor', [0.95 0.95 0.95]);
lat_intd_edit = uicontrol('Parent', panel_bottom, 'Style', 'edit', 'String', '', 'Units', 'normalized', 'Position', [0.21 0.7 0.15 0.2], 'FontSize', 11);
uicontrol('Parent', panel_bottom, 'Style', 'text', 'String', 'Longitudine:', 'Units', 'normalized', 'Position', [0.38 0.7 0.22 0.2], 'FontSize', 11, 'BackgroundColor', [0.95 0.95 0.95]);
lon_intd_edit = uicontrol('Parent', panel_bottom, 'Style', 'edit', 'String', '', 'Units', 'normalized', 'Position', [0.54 0.7 0.15 0.2], 'FontSize', 11);
uicontrol('Parent', panel_bottom, 'Style', 'text', 'String', 'Velocità (kts):', 'Units', 'normalized', 'Position', [0.05 0.4 0.22 0.2], 'FontSize', 11, 'BackgroundColor', [0.95 0.95 0.95]);
vel_intd_edit = uicontrol('Parent', panel_bottom, 'Style', 'edit', 'String', '', 'Units', 'normalized', 'Position', [0.21 0.4 0.15 0.2], 'FontSize', 11);
uicontrol('Parent', panel_bottom, 'Style', 'text', 'String', 'Prua (gradi):', 'Units', 'normalized', 'Position', [0.38 0.4 0.22 0.2], 'FontSize', 11, 'BackgroundColor', [0.95 0.95 0.95]);
prua_intd_edit = uicontrol('Parent', panel_bottom, 'Style', 'edit', 'String', '', 'Units', 'normalized', 'Position', [0.54 0.4 0.15 0.2], 'FontSize', 11);

btn_calcola = uicontrol('Parent', f, 'Style', 'pushbutton', 'String', 'Calcola intercettazione', ...
	'Units', 'normalized', 'Position', [0.05 0.63 0.2 0.05], 'FontSize', 12, ...
	'Callback', @(src,~) calcola_intercettazione(src));

% Casi pre-impostati
presets = { ...
	struct('name', 'rotta intercettazione nave in avaria', 'lat_intc', '36.70 N', 'lon_intc', '14.82 E', 'vel_intc', '25', ...
		'lat_intd', '36.42 N', 'lon_intd', '14.71 E', 'vel_intd', '4', 'prua_intd', '135'); ...
	struct('name', 'intercettazione nave per pilotaggio Stretto di Messina', 'lat_intc', '38.18 N', 'lon_intc', '15.55 E', 'vel_intc', '20', ...
		'lat_intd', '37.86 N', 'lon_intd', '15.55 E', 'vel_intd', '12', 'prua_intd', '10'); ...
	struct('name', 'intercettazione oceano indiano', 'lat_intc', '31.99 S', 'lon_intc', '115.57 E', 'vel_intc', '22', ...
		'lat_intd', '28.08 S', 'lon_intd', '109.49 E', 'vel_intd', '17', 'prua_intd', '10'); ...
	struct('name', 'soccorso nel golfo del messico', 'lat_intc', '29.48 N', 'lon_intc', '94.26 W', 'vel_intc', '20', ...
		'lat_intd', '24.82 N', 'lon_intd', '91.85 W', 'vel_intd', '8', 'prua_intd', '260') ...
};

preset_label = uicontrol('Parent', f, 'Style', 'text', 'String', 'Preset:', ...
	'Units', 'normalized', 'Position', [0.27 0.63 0.08 0.05], 'FontSize', 11, ...
	'BackgroundColor', [0.95 0.95 0.95], 'HorizontalAlignment', 'left');

preset_checkbox = uicontrol('Parent', f, 'Style', 'checkbox', 'String', 'Usa preset', ...
	'Units', 'normalized', 'Position', [0.27 0.595 0.15 0.035], 'FontSize', 10, ...
	'BackgroundColor', [0.95 0.95 0.95], 'Value', 0, ...
	'Callback', @(src,~) toggle_preset_controls());

preset_names = {'Seleziona preset'};
for i = 1:length(presets)
	preset_names{end+1} = presets{i}.name;
end
preset_popup = uicontrol('Parent', f, 'Style', 'popupmenu', 'String', preset_names, ...
	'Units', 'normalized', 'Position', [0.35 0.635 0.18 0.045], 'FontSize', 11, ...
	'BackgroundColor', [1 1 1], 'Enable', 'off');

preset_button = uicontrol('Parent', f, 'Style', 'pushbutton', 'String', 'Carica preset', ...
	'Units', 'normalized', 'Position', [0.54 0.63 0.11 0.05], 'FontSize', 11, ...
	'Enable', 'off', 'Callback', @(src,~) apply_preset(get(preset_popup, 'Value')));

% Principali basi SAR (coordinate approssimative, con nomi)
sar_lat = [25.7781, 44.6488, 64.1265, 38.7223, -33.9249, -31.9505, 35.6762, 21.3069, -36.8485, -34.6037, ...
	51.4700, 40.7128, 34.0522, 1.3521, 55.7558, 35.6895, 48.8566, 19.4326, -23.5505, 59.3293, 60.1699, 37.9838, 41.9028, 39.9042, ...
	14.6710, 24.9474, 22.3193, 12.6667, 5.3521, -37.8136, -20.2606, -8.7832, 11.5564, 36.7537, 31.2454, 13.1939, 7.1095, 4.0511, -4.0383, -33.8688, ...
	21.3099, 13.1857, 22.5597, 40.7306, 22.2793, 29.9759, 5.1104, 18.5243, 25.2048, 1.3521];

sar_lon = [-80.1794, -63.5752, -21.8174, -9.1393, 18.4241, 115.8605, 139.6503, -157.8583, 174.7633, -58.3816, ...
	-0.4543, -74.0060, -118.2437, 103.8198, 37.6173, 139.6917, 2.3522, -99.1332, -46.6333, 18.0686, 24.9384, 23.7275, 12.4964, 116.4074, ...
	-17.0832, 55.2708, 114.1696, 44.3615, -1.9536, 144.9631, 57.5522, -13.1939, 43.1621, 3.5898, 32.8872, 104.8673, -60.7269, -74.0121, 37.2808, 151.2093, ...
	-157.8583, -89.2381, 88.3639, 141.6671, 120.6737, 47.9244, -77.1119, -69.9485, 55.4164, 103.8198];

sar_names = { ...
	'Miami', 'Halifax', 'Reykjavik', 'Lisbon', 'Cape Town', 'Perth', 'Tokyo', 'Honolulu', 'Auckland', 'Buenos Aires', ...
	'London', 'New York', 'Los Angeles', 'Singapore', 'Moscow', 'Tokyo', 'Paris', 'Mexico City', 'Sao Paulo', 'Stockholm', ...
	'Helsinki', 'Athens', 'Rome', 'Beijing', ...
	'Dakar', 'Dubai', 'Jakarta', 'Baghdad', 'Monrovia', 'Melbourne', 'Mauritius', 'Dar es Salaam', 'Port Sudan', 'Gibraltar', ...
	'Panama', 'Cartagena', 'Port Said', 'Istanbul', 'Aden', 'Mombasa', 'Mogadisio', 'Callao', 'Sydney', ...
	'Honolulu (2)', 'Puerto Cortes', 'Bangkok', 'Manila', 'Hong Kong', 'Colombo', 'Veracruz', 'Santos', 'Male', 'Kuala Lumpur'};

% Carica coastlines una volta (se disponibile)
try
	coast = load('coastlines');
	coastlat = coast.coastlat;
	coastlon = coast.coastlon;
catch
	coastlat = [];
	coastlon = [];
end

% Salva handles con guidata
handles = struct();
handles.f = f;
handles.panel_top = panel_top;
handles.panel_bottom = panel_bottom;
handles.btn_calcola = btn_calcola;
handles.lat_intc_edit = lat_intc_edit;
handles.lon_intc_edit = lon_intc_edit;
handles.vel_intc_edit = vel_intc_edit;
handles.lat_intd_edit = lat_intd_edit;
handles.lon_intd_edit = lon_intd_edit;
handles.vel_intd_edit = vel_intd_edit;
handles.prua_intd_edit = prua_intd_edit;
handles.sar_lat = sar_lat;
handles.sar_lon = sar_lon;
handles.sar_names = sar_names;
handles.presets = presets;
handles.preset_popup = preset_popup;
handles.preset_button = preset_button;
handles.preset_checkbox = preset_checkbox;
handles.preset_label = preset_label;
guidata(f, handles);

toggle_preset_controls();

% Callback per mostrare nome e coordinate precise al click su un punto SAR
% (ora la callback viene impostata dopo la creazione della mappa)

% --- Funzione annidata per il calcolo ---

	function calcola_intercettazione(src)
		try
			h = guidata(f);
			if ~isstruct(h)
				h = guidata(src);
			end
			% Leggi dati (rimuove °, N, S, E, W e converte virgola in punto)
			lat_intc = parse_coordinate(get(h.lat_intc_edit, 'String'));
			lon_intc = parse_coordinate(get(h.lon_intc_edit, 'String'));
			vel_intc = parse_number(get(h.vel_intc_edit, 'String'));
			lat_intd = parse_coordinate(get(h.lat_intd_edit, 'String'));
			lon_intd = parse_coordinate(get(h.lon_intd_edit, 'String'));
			vel_intd = parse_number(get(h.vel_intd_edit, 'String'));
			prua_intd = parse_number(get(h.prua_intd_edit, 'String'));

			if any(isnan([lat_intc, lon_intc, vel_intc, lat_intd, lon_intd, vel_intd, prua_intd]))
				errordlg('Inserisci tutti i campi numerici.', 'Dati mancanti');
				return;
			end

			% Conversione velocità da nodi a km/h
			vel_intc_kmh = vel_intc * 1.852;
			vel_intd_kmh = vel_intd * 1.852;

			% Conversione coordinate geografiche in coordinate cartesiane (approssimazione locale)
			R = 6371; % raggio medio terrestre in km
			lat0 = lat_intc; lon0 = lon_intc;
			x1 = 0;
			y1 = 0;
			x2 = (lon_intd - lon0) * cosd((lat0+lat_intd)/2) * pi/180 * R;
			y2 = (lat_intd - lat0) * pi/180 * R;

			% Vettori velocità in coordinate cartesiane
			v2x = vel_intd_kmh * sind(prua_intd); % 0°=Nord, 90°=Est
			v2y = vel_intd_kmh * cosd(prua_intd);

			dx = x2 - x1;
			dy = y2 - y1;

			% Risolvo il sistema per il tempo di intercettazione
			A = v2x^2 + v2y^2 - vel_intc_kmh^2;
			B = 2*(dx*v2x + dy*v2y);
			C = dx^2 + dy^2;
			
			% Caso 1: Equazione quadratica (A ~= 0)
			if abs(A) > 1e-6
				delta = B^2 - 4*A*C;
				if delta >= 0
					t1 = (-B + sqrt(delta))/(2*A);
					t2 = (-B - sqrt(delta))/(2*A);
					% Prendi il minimo tempo positivo (prima intercettazione)
					tempi_positivi = [t1, t2];
					tempi_positivi = tempi_positivi(tempi_positivi > 0);
					if ~isempty(tempi_positivi)
						tempo = min(tempi_positivi);
					else
						tempo = NaN;
					end
				else
					tempo = NaN; % Nessuna soluzione reale
				end
			% Caso 2: Equazione lineare (A ≈ 0, velocità uguale)
			elseif abs(B) > 1e-6
				tempo = -C / B;
				if tempo <= 0
					tempo = NaN;
				end
			else
				tempo = NaN; % Intercettazione impossibile
			end

			if ~isnan(tempo)
				% Posizione di intercettazione in coordinate cartesiane
				x_int = x2 + v2x*tempo;
				y_int = y2 + v2y*tempo;
				% Riconversione in lat/lon
				lat_int = lat0 + (y_int/pi/R)*180;
				lon_int = lon0 + (x_int/pi/R)*180/cosd((lat0+lat_int)/2);
				% Rotta da intercettore verso punto di intercettazione
			rotta = calculate_azimuth(lat_intc, lon_intc, lat_int, lon_int);
			else
				lat_int = NaN;
				lon_int = NaN;
				rotta = NaN;
			end

			% Chiudi pannelli input
			delete(h.panel_top);
			delete(h.panel_bottom);
			delete(h.btn_calcola);
			if isfield(h, 'preset_label') && isgraphics(h.preset_label)
				delete(h.preset_label);
			end
			if isfield(h, 'preset_checkbox') && isgraphics(h.preset_checkbox)
				delete(h.preset_checkbox);
			end
			if isfield(h, 'preset_popup') && isgraphics(h.preset_popup)
				delete(h.preset_popup);
			end
			if isfield(h, 'preset_button') && isgraphics(h.preset_button)
				delete(h.preset_button);
			end

			% Crea mappa e pannello dati
			ax = axes('Parent', h.f);
			set(ax, 'Position', [0.05 0.05 0.63 0.93]);
			hold(ax, 'on');
			box(ax, 'on');
			set(ax, 'Color', [1 1 1]);
		
			% Coastlines
			if ~isempty(coastlat)
				plot(ax, coastlon, coastlat, 'k-', 'LineWidth', 1.2);
			end
		
			% Meridiani e paralleli
			for lon_line = -180:30:180
				plot(ax, [lon_line lon_line], [-90 90], 'k:', 'LineWidth', 0.5, 'Color', [0.5 0.5 0.5]);
			end
			for lat_line = -60:30:60
				plot(ax, [-180 180], [lat_line lat_line], 'k:', 'LineWidth', 0.5, 'Color', [0.5 0.5 0.5]);
			end
			% Equatore e meridiano di Greenwich
			plot(ax, [-180 180], [0 0], 'k-', 'LineWidth', 1.0, 'Color', [0.3 0.3 0.3]);
			plot(ax, [0 0], [-90 90], 'k-', 'LineWidth', 1.0, 'Color', [0.3 0.3 0.3]);
		
			axis(ax, [-180 180 -90 90]);
			xlabel(ax, 'Longitudine [°]');
			ylabel(ax, 'Latitudine [°]');
			title(ax, 'Mappa mondiale');
		
			% Abilita spostamento mappa con il cursore (pan) e zoom manuale
			pan(h.f, 'on');
			zoom(h.f, 'on');

		eta_str = '--';
		if ~isnan(tempo)
			eta_hours = floor(tempo);
			eta_minutes = round((tempo - eta_hours) * 60);
			if eta_minutes == 60
				eta_hours = eta_hours + 1;
				eta_minutes = 0;
			end
			eta_str = sprintf('%dh %02dm', eta_hours, eta_minutes);
		end

		panel_dati = uipanel('Parent', h.f, 'Title', 'DATI INTERCETTORE / INTERCETTATO', 'FontSize', 12, ...
			'BackgroundColor', [0.95 0.95 0.95], 'Position', [0.68 0.05 0.3 0.93]);

		uicontrol('Parent', panel_dati, 'Style', 'text', 'String', ...
			sprintf('Intercettore:\nLat: %.4f\nLon: %.4f\nVelocità: %.2f kts\n\nRotta: %.1f°\nE.T.A.: %s\n\nPunto Int.:\nLat: %.4f\nLon: %.4f', ...
			lat_intc, lon_intc, vel_intc, rotta, eta_str, lat_int, lon_int), ...
			'Units', 'normalized', 'Position', [0.05 0.2 0.4 0.75], 'FontSize', 12, ...
			'FontWeight', 'bold', 'HorizontalAlignment', 'left', 'BackgroundColor', [0.95 0.95 0.95]);
		
		% Linea separatoria nera verticale (visibile all'interno del pannello)
		annotation(h.f, 'line', [0.83 0.83], [0.05 0.93], 'Color', 'k', 'LineWidth', 2);
		
		uicontrol('Parent', panel_dati, 'Style', 'text', 'String', ...
			sprintf('Intercettato:\nLat: %.4f\nLon: %.4f\nVelocità: %.2f kts\nPrua: %.1f°', ...
			lat_intd, lon_intd, vel_intd, prua_intd), ...
			'Units', 'normalized', 'Position', [0.5 0.6 0.45 0.35], 'FontSize', 12, ...
			'FontWeight', 'bold', 'HorizontalAlignment', 'left', 'BackgroundColor', [0.95 0.95 0.95]);
		
		% Pulsante per modificare i dati
		uicontrol('Parent', panel_dati, 'Style', 'pushbutton', 'String', 'Modifica Dati', ...
			'Units', 'normalized', 'Position', [0.5 0.52 0.45 0.06], 'FontSize', 12, 'FontWeight', 'bold', ...
			'BackgroundColor', [0.3 0.6 0.9], 'ForegroundColor', [1 1 1], ...
			'Callback', @(src,~) modifica_dati_callback(h.f, ax, panel_dati, lat_intc, lon_intc, vel_intc, lat_intd, lon_intd, vel_intd, prua_intd));
		
		% Legenda
		uicontrol('Parent', panel_dati, 'Style', 'text', 'String', 'LEGENDA:', ...
			'Units', 'normalized', 'Position', [0.05 0.42 0.9 0.03], 'FontSize', 11, 'FontWeight', 'bold', ...
			'HorizontalAlignment', 'left', 'BackgroundColor', [0.95 0.95 0.95]);
		
		uicontrol('Parent', panel_dati, 'Style', 'text', 'String', '●  Cerchio viola:', ...
			'Units', 'normalized', 'Position', [0.05 0.37 0.9 0.03], 'FontSize', 10, ...
			'HorizontalAlignment', 'left', 'ForegroundColor', [0.6 0 1], 'BackgroundColor', [0.95 0.95 0.95]);
		uicontrol('Parent', panel_dati, 'Style', 'text', 'String', '     Intercettore', ...
			'Units', 'normalized', 'Position', [0.05 0.34 0.9 0.03], 'FontSize', 9, ...
			'HorizontalAlignment', 'left', 'BackgroundColor', [0.95 0.95 0.95]);
		
		uicontrol('Parent', panel_dati, 'Style', 'text', 'String', '●  Cerchio verde:', ...
			'Units', 'normalized', 'Position', [0.05 0.31 0.9 0.03], 'FontSize', 10, ...
			'HorizontalAlignment', 'left', 'ForegroundColor', [0 0.7 0], 'BackgroundColor', [0.95 0.95 0.95]);
		uicontrol('Parent', panel_dati, 'Style', 'text', 'String', '     Nave da intercettare', ...
			'Units', 'normalized', 'Position', [0.05 0.28 0.9 0.03], 'FontSize', 9, ...
			'HorizontalAlignment', 'left', 'BackgroundColor', [0.95 0.95 0.95]);
		
		uicontrol('Parent', panel_dati, 'Style', 'text', 'String', '✕  X blu:', ...
			'Units', 'normalized', 'Position', [0.05 0.25 0.9 0.03], 'FontSize', 10, ...
			'HorizontalAlignment', 'left', 'ForegroundColor', [0 0 1], 'BackgroundColor', [0.95 0.95 0.95]);
		uicontrol('Parent', panel_dati, 'Style', 'text', 'String', '     Punto di intercettazione', ...
			'Units', 'normalized', 'Position', [0.05 0.22 0.9 0.03], 'FontSize', 9, ...
			'HorizontalAlignment', 'left', 'BackgroundColor', [0.95 0.95 0.95]);
		
		uicontrol('Parent', panel_dati, 'Style', 'text', 'String', '●  Cerchi rossi:', ...
			'Units', 'normalized', 'Position', [0.05 0.17 0.9 0.03], 'FontSize', 10, ...
			'HorizontalAlignment', 'left', 'ForegroundColor', [1 0 0], 'BackgroundColor', [0.95 0.95 0.95]);
		uicontrol('Parent', panel_dati, 'Style', 'text', 'String', '     Basi SAR', ...
			'Units', 'normalized', 'Position', [0.05 0.14 0.9 0.03], 'FontSize', 9, ...
			'HorizontalAlignment', 'left', 'BackgroundColor', [0.95 0.95 0.95]);

		% Visualizza punti sulla mappa (intercettore e nave intercettata separati)
		plot(ax, lon_intc, lat_intc, 'mo', 'MarkerSize', 10, 'MarkerFaceColor', 'm');  % Intercettore: cerchio viola
		plot(ax, lon_intd, lat_intd, 'go', 'MarkerSize', 8, 'MarkerFaceColor', 'g');  % Nave intercettata: cerchio verde
		if ~isnan(lat_int)
			% Vettori che convergono al punto di intercettazione
			extend_factor = 0.7;
			% Intercettore -> punto di intercettazione
			dir_intc_lon = lon_int - lon_intc;
			dir_intc_lat = lat_int - lat_intc;
			if dir_intc_lon ~= 0 || dir_intc_lat ~= 0
				quiver(ax, lon_intc, lat_intc, dir_intc_lon * (1 + extend_factor), dir_intc_lat * (1 + extend_factor), 0, 'Color', [1 0 1], 'LineWidth', 2.5, 'MaxHeadSize', 0.5);
			end
			
			% Intercettato -> punto di intercettazione
			dir_nave_lon = lon_int - lon_intd;
			dir_nave_lat = lat_int - lat_intd;
			if dir_nave_lon ~= 0 || dir_nave_lat ~= 0
				quiver(ax, lon_intd, lat_intd, dir_nave_lon * (1 + extend_factor) * 1.5, dir_nave_lat * (1 + extend_factor) * 1.5, 0, 'Color', [0 1 0], 'LineWidth', 3.5, 'MaxHeadSize', 0.7);
			end
			
			% Visualizza il punto di intercettazione con X blu
			plot(ax, lon_int, lat_int, 'bx', 'MarkerSize', 12, 'LineWidth', 2);  % Punto di intercettazione: X blu
		end

		% Plotta i punti SAR e imposta la callback
		hSAR = plot(ax, h.sar_lon, h.sar_lat, 'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 4);
		set(hSAR, 'ButtonDownFcn', @(src, event) sar_click_callback(src, h.sar_lat, h.sar_lon, h.sar_names));
		hold(ax, 'off');
		
		% Zoom graduale animato verso il punto di intercettazione
		if ~isnan(lat_int)
			% Calcola i limiti finali dell'area di interesse
			% Includi intercettore, intercettato e punto di intercettazione
			all_lats = [lat_intc, lat_intd, lat_int];
			all_lons = [lon_intc, lon_intd, lon_int];
			lat_center = mean(all_lats);
			lon_center = mean(all_lons);
			lat_range = max(all_lats) - min(all_lats);
			lon_range = max(all_lons) - min(all_lons);
			% Aggiungi un margine del 50%
			margin = 1.5;
			lat_span = max(lat_range * margin, 2); % Minimo 2 gradi
			lon_span = max(lon_range * margin, 2); % Minimo 2 gradi
			
			% Limiti finali
			final_xlim = [lon_center - lon_span, lon_center + lon_span];
			final_ylim = [lat_center - lat_span, lat_center + lat_span];
			
			% Limiti iniziali (globali)
			initial_xlim = [-180, 180];
			initial_ylim = [-90, 90];
			
			% Animazione zoom graduale con easing più fluido
			num_steps = 80; % Aumentato per maggiore fluidità
			for i = 1:num_steps
				t = i / num_steps; % Parametro di interpolazione (0 a 1)
				% Easing in-out cubic per movimento più naturale
				if t < 0.5
					t_smooth = 4 * t^3;
				else
					t_smooth = 1 - (-2 * t + 2)^3 / 2;
				end
				
				% Interpola i limiti
				current_xlim = initial_xlim + t_smooth * (final_xlim - initial_xlim);
				current_ylim = initial_ylim + t_smooth * (final_ylim - initial_ylim);
				
				% Applica i nuovi limiti
				xlim(ax, current_xlim);
				ylim(ax, current_ylim);
				drawnow;
				pause(0.015); % Pausa ridotta per animazione più fluida
			end
			
			% Assicura limiti finali esatti
			xlim(ax, final_xlim);
			ylim(ax, final_ylim);
		end
		
		% Zoom gestito manualmente dall'utente
	catch ME
		errordlg(ME.message, 'Errore nel calcolo');
	end
	end

	% Funzione annidata per parsare coordinate
	function val = parse_coordinate(str)
		str = strtrim(str);
		str = strrep(str, '°', '');
		str = strrep(str, ',', '.');
		num_str = regexp(str, '[0-9.]+', 'match');
		if isempty(num_str)
			val = NaN;
			return;
		end
		val = str2double(num_str{1});
		str_up = upper(str);
		if contains(str_up, 'S') || contains(str_up, 'W')
			val = -abs(val);
		else
			val = abs(val);
		end
	end

	% Funzione annidata per parsare numeri
	function val = parse_number(str)
		str = strtrim(str);
		str = strrep(str, ',', '.');
		val = str2double(str);
	end

	% Funzione per calcolare l'azimuth (rotta) senza Mapping Toolbox
	function bearing = calculate_azimuth(lat1, lon1, lat2, lon2)
		% Converte a radianti
		lat1_rad = lat1 * pi / 180;
		lon1_rad = lon1 * pi / 180;
		lat2_rad = lat2 * pi / 180;
		lon2_rad = lon2 * pi / 180;
		
		dlon = lon2_rad - lon1_rad;
		y = sin(dlon) * cos(lat2_rad);
		x = cos(lat1_rad) * sin(lat2_rad) - sin(lat1_rad) * cos(lat2_rad) * cos(dlon);
		bearing = atan2(y, x) * 180 / pi;
		
		% Normalizza a 0-360 gradi
		if bearing < 0
			bearing = bearing + 360;
		end
	end

	% Abilita/Disabilita controlli preset
	function toggle_preset_controls()
		h = guidata(f);
		if get(h.preset_checkbox, 'Value') == 1
			set(h.preset_popup, 'Enable', 'on');
			set(h.preset_button, 'Enable', 'on');
		else
			set(h.preset_popup, 'Enable', 'off');
			set(h.preset_button, 'Enable', 'off');
		end
	end

	% Funzione per applicare un preset
	function apply_preset(idx)
		h = guidata(f);
		if idx <= 1
			return;
		end
		p = h.presets{idx - 1};
		set(h.lat_intc_edit, 'String', p.lat_intc);
		set(h.lon_intc_edit, 'String', p.lon_intc);
		set(h.vel_intc_edit, 'String', p.vel_intc);
		set(h.lat_intd_edit, 'String', p.lat_intd);
		set(h.lon_intd_edit, 'String', p.lon_intd);
		set(h.vel_intd_edit, 'String', p.vel_intd);
		set(h.prua_intd_edit, 'String', p.prua_intd);
	end
	
	% Funzione per modificare i dati
	function modifica_dati_callback(figura, ax_map, panel_dati_old, lat_intc, lon_intc, vel_intc, lat_intd, lon_intd, vel_intd, prua_intd)
		% Cancella mappa e pannello dati
		delete(ax_map);
		delete(panel_dati_old);
		
		% Ricrea i pannelli di input con i valori attuali
		panel_top = uipanel('Parent', figura, 'Title', 'INTERCETTORE', 'FontSize', 11, ...
			'BackgroundColor', [0.95 0.95 0.95], 'Position', [0.05 0.85 0.6 0.13]);
		uicontrol('Parent', panel_top, 'Style', 'text', 'String', 'Latitudine:', 'Units', 'normalized', 'Position', [0.05 0.7 0.22 0.2], 'FontSize', 11, 'BackgroundColor', [0.95 0.95 0.95]);
		lat_intc_edit = uicontrol('Parent', panel_top, 'Style', 'edit', 'String', sprintf('%.4f', abs(lat_intc)), 'Units', 'normalized', 'Position', [0.21 0.7 0.15 0.2], 'FontSize', 11);
		uicontrol('Parent', panel_top, 'Style', 'text', 'String', 'Longitudine:', 'Units', 'normalized', 'Position', [0.38 0.7 0.22 0.2], 'FontSize', 11, 'BackgroundColor', [0.95 0.95 0.95]);
		lon_intc_edit = uicontrol('Parent', panel_top, 'Style', 'edit', 'String', sprintf('%.4f', abs(lon_intc)), 'Units', 'normalized', 'Position', [0.54 0.7 0.15 0.2], 'FontSize', 11);
		uicontrol('Parent', panel_top, 'Style', 'text', 'String', 'Velocità (kts):', 'Units', 'normalized', 'Position', [0.05 0.4 0.22 0.2], 'FontSize', 11, 'BackgroundColor', [0.95 0.95 0.95]);
		vel_intc_edit = uicontrol('Parent', panel_top, 'Style', 'edit', 'String', sprintf('%.2f', vel_intc), 'Units', 'normalized', 'Position', [0.21 0.4 0.15 0.2], 'FontSize', 11);

		panel_bottom = uipanel('Parent', figura, 'Title', 'NAVE DA INTERCETTARE', 'FontSize', 11, ...
			'BackgroundColor', [0.95 0.95 0.95], 'Position', [0.05 0.7 0.6 0.13]);
		uicontrol('Parent', panel_bottom, 'Style', 'text', 'String', 'Latitudine:', 'Units', 'normalized', 'Position', [0.05 0.7 0.22 0.2], 'FontSize', 11, 'BackgroundColor', [0.95 0.95 0.95]);
		lat_intd_edit = uicontrol('Parent', panel_bottom, 'Style', 'edit', 'String', sprintf('%.4f', abs(lat_intd)), 'Units', 'normalized', 'Position', [0.21 0.7 0.15 0.2], 'FontSize', 11);
		uicontrol('Parent', panel_bottom, 'Style', 'text', 'String', 'Longitudine:', 'Units', 'normalized', 'Position', [0.38 0.7 0.22 0.2], 'FontSize', 11, 'BackgroundColor', [0.95 0.95 0.95]);
		lon_intd_edit = uicontrol('Parent', panel_bottom, 'Style', 'edit', 'String', sprintf('%.4f', abs(lon_intd)), 'Units', 'normalized', 'Position', [0.54 0.7 0.15 0.2], 'FontSize', 11);
		uicontrol('Parent', panel_bottom, 'Style', 'text', 'String', 'Velocità (kts):', 'Units', 'normalized', 'Position', [0.05 0.4 0.22 0.2], 'FontSize', 11, 'BackgroundColor', [0.95 0.95 0.95]);
		vel_intd_edit = uicontrol('Parent', panel_bottom, 'Style', 'edit', 'String', sprintf('%.2f', vel_intd), 'Units', 'normalized', 'Position', [0.21 0.4 0.15 0.2], 'FontSize', 11);
		uicontrol('Parent', panel_bottom, 'Style', 'text', 'String', 'Prua (gradi):', 'Units', 'normalized', 'Position', [0.38 0.4 0.22 0.2], 'FontSize', 11, 'BackgroundColor', [0.95 0.95 0.95]);
		prua_intd_edit = uicontrol('Parent', panel_bottom, 'Style', 'edit', 'String', sprintf('%.1f', prua_intd), 'Units', 'normalized', 'Position', [0.54 0.4 0.15 0.2], 'FontSize', 11);

		btn_calcola = uicontrol('Parent', figura, 'Style', 'pushbutton', 'String', 'Calcola intercettazione', ...
			'Units', 'normalized', 'Position', [0.05 0.63 0.2 0.05], 'FontSize', 12, ...
			'Callback', @(src,~) calcola_intercettazione(src));

		preset_label = uicontrol('Parent', figura, 'Style', 'text', 'String', 'Preset:', ...
			'Units', 'normalized', 'Position', [0.27 0.63 0.08 0.05], 'FontSize', 11, ...
			'BackgroundColor', [0.95 0.95 0.95], 'HorizontalAlignment', 'left');

		preset_checkbox = uicontrol('Parent', figura, 'Style', 'checkbox', 'String', 'Usa preset', ...
			'Units', 'normalized', 'Position', [0.27 0.595 0.15 0.035], 'FontSize', 10, ...
			'BackgroundColor', [0.95 0.95 0.95], 'Value', 0, ...
			'Callback', @(src,~) toggle_preset_controls());

		preset_names = {'Seleziona preset'};
		for i = 1:length(presets)
			preset_names{end+1} = presets{i}.name;
		end
		preset_popup = uicontrol('Parent', figura, 'Style', 'popupmenu', 'String', preset_names, ...
			'Units', 'normalized', 'Position', [0.35 0.635 0.18 0.045], 'FontSize', 11, ...
			'BackgroundColor', [1 1 1], 'Enable', 'off');

		preset_button = uicontrol('Parent', figura, 'Style', 'pushbutton', 'String', 'Carica preset', ...
			'Units', 'normalized', 'Position', [0.54 0.63 0.11 0.05], 'FontSize', 11, ...
			'Enable', 'off', 'Callback', @(src,~) apply_preset(get(preset_popup, 'Value')));
		
		% Aggiorna guidata
		h = guidata(figura);
		h.panel_top = panel_top;
		h.panel_bottom = panel_bottom;
		h.btn_calcola = btn_calcola;
		h.lat_intc_edit = lat_intc_edit;
		h.lon_intc_edit = lon_intc_edit;
		h.vel_intc_edit = vel_intc_edit;
		h.lat_intd_edit = lat_intd_edit;
		h.lon_intd_edit = lon_intd_edit;
		h.vel_intd_edit = vel_intd_edit;
		h.prua_intd_edit = prua_intd_edit;
		h.presets = presets;
		h.preset_popup = preset_popup;
		h.preset_button = preset_button;
		h.preset_checkbox = preset_checkbox;
		h.preset_label = preset_label;
		guidata(figura, h);

		toggle_preset_controls();
	end
end

% Callback per mostrare nome e coordinate precise al click su un punto SAR
function sar_click_callback(~, lat, lon, names)
	% Ottieni posizione del click in coordinate assi
	pt = get(gca, 'CurrentPoint');
	x = pt(1,1);
	y = pt(1,2);
	% Per la proiezione Mercatore di axesm, x=longitudine e y=latitudine
	click_lon = x;
	click_lat = y;
	% Assicura che lat e lon siano vettori colonna
	lat = lat(:);
	lon = lon(:);
	% Calcola distanza euclidea tra click e tutti i punti SAR
	d = sqrt((lat - click_lat).^2 + (lon - click_lon).^2);
	[~, idx] = min(d);
	% Mostra etichetta con nome e coordinate precise
	txt = sprintf('%s\nLat: %.6f\nLon: %.6f', names{idx}, lat(idx), lon(idx));
	text(lon(idx), lat(idx), txt, 'FontSize', 9, 'BackgroundColor', 'w', 'EdgeColor', 'k');
end


