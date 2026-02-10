function mappa_globale
f = figure('Position', [100, 100, 1400, 800]);

% Solo pannelli input all'avvio
panel_top = uipanel('Parent', f, 'Title', 'INTERCETTORE', 'FontSize', 11, ...
	'BackgroundColor', [0.95 0.95 0.95], 'Position', [0.05 0.85 0.6 0.13]);
uicontrol('Parent', panel_top, 'Style', 'text', 'String', 'Latitudine:', 'Units', 'normalized', 'Position', [0.05 0.7 0.15 0.2], 'FontSize', 11, 'BackgroundColor', [0.95 0.95 0.95]);
lat_intc_edit = uicontrol('Parent', panel_top, 'Style', 'edit', 'String', '', 'Units', 'normalized', 'Position', [0.21 0.7 0.15 0.2], 'FontSize', 11);
uicontrol('Parent', panel_top, 'Style', 'text', 'String', 'Longitudine:', 'Units', 'normalized', 'Position', [0.38 0.7 0.15 0.2], 'FontSize', 11, 'BackgroundColor', [0.95 0.95 0.95]);
lon_intc_edit = uicontrol('Parent', panel_top, 'Style', 'edit', 'String', '', 'Units', 'normalized', 'Position', [0.54 0.7 0.15 0.2], 'FontSize', 11);
uicontrol('Parent', panel_top, 'Style', 'text', 'String', 'Velocità (kts):', 'Units', 'normalized', 'Position', [0.05 0.4 0.15 0.2], 'FontSize', 11, 'BackgroundColor', [0.95 0.95 0.95]);
vel_intc_edit = uicontrol('Parent', panel_top, 'Style', 'edit', 'String', '', 'Units', 'normalized', 'Position', [0.21 0.4 0.15 0.2], 'FontSize', 11);

panel_bottom = uipanel('Parent', f, 'Title', 'NAVE DA INTERCETTARE', 'FontSize', 11, ...
	'BackgroundColor', [0.95 0.95 0.95], 'Position', [0.05 0.7 0.6 0.13]);
uicontrol('Parent', panel_bottom, 'Style', 'text', 'String', 'Latitudine:', 'Units', 'normalized', 'Position', [0.05 0.7 0.15 0.2], 'FontSize', 11, 'BackgroundColor', [0.95 0.95 0.95]);
lat_intd_edit = uicontrol('Parent', panel_bottom, 'Style', 'edit', 'String', '', 'Units', 'normalized', 'Position', [0.21 0.7 0.15 0.2], 'FontSize', 11);
uicontrol('Parent', panel_bottom, 'Style', 'text', 'String', 'Longitudine:', 'Units', 'normalized', 'Position', [0.38 0.7 0.15 0.2], 'FontSize', 11, 'BackgroundColor', [0.95 0.95 0.95]);
lon_intd_edit = uicontrol('Parent', panel_bottom, 'Style', 'edit', 'String', '', 'Units', 'normalized', 'Position', [0.54 0.7 0.15 0.2], 'FontSize', 11);
uicontrol('Parent', panel_bottom, 'Style', 'text', 'String', 'Velocità (kts):', 'Units', 'normalized', 'Position', [0.05 0.4 0.15 0.2], 'FontSize', 11, 'BackgroundColor', [0.95 0.95 0.95]);
vel_intd_edit = uicontrol('Parent', panel_bottom, 'Style', 'edit', 'String', '', 'Units', 'normalized', 'Position', [0.21 0.4 0.15 0.2], 'FontSize', 11);
uicontrol('Parent', panel_bottom, 'Style', 'text', 'String', 'Prua (gradi):', 'Units', 'normalized', 'Position', [0.38 0.4 0.15 0.2], 'FontSize', 11, 'BackgroundColor', [0.95 0.95 0.95]);
prua_intd_edit = uicontrol('Parent', panel_bottom, 'Style', 'edit', 'String', '', 'Units', 'normalized', 'Position', [0.54 0.4 0.15 0.2], 'FontSize', 11);

btn_calcola = uicontrol('Parent', f, 'Style', 'pushbutton', 'String', 'Calcola intercettazione', ...
	'Units', 'normalized', 'Position', [0.05 0.63 0.2 0.05], 'FontSize', 12, ...
	'Callback', @(src,~) calcola_intercettazione(src));

% Principali basi SAR (coordinate approssimative, con nomi)
sar_lat = [25.7781, 44.6488, 64.1265, 38.7223, -33.9249, -31.9505, 35.6762, 21.3069, -36.8485, -34.6037, ...
	51.4700, 40.7128, 34.0522, 1.3521, 55.7558, 35.6895, 48.8566, 19.4326, -23.5505, 59.3293, 60.1699, 37.9838, 41.9028, 39.9042];
sar_lon = [-80.1794, -63.5752, -21.8174, -9.1393, 18.4241, 115.8605, 139.6503, -157.8583, 174.7633, -58.3816, ...
	-0.4543, -74.0060, -118.2437, 103.8198, 37.6173, 139.6917, 2.3522, -99.1332, -46.6333, 18.0686, 24.9384, 23.7275, 12.4964, 116.4074];
sar_names = { ...
	'Miami', 'Halifax', 'Reykjavik', 'Lisbon', 'Cape Town', 'Perth', 'Tokyo', 'Honolulu', 'Auckland', 'Buenos Aires', ...
	'London', 'New York', 'Los Angeles', 'Singapore', 'Moscow', 'Tokyo', 'Paris', 'Mexico City', 'Sao Paulo', 'Stockholm', ...
	'Helsinki', 'Athens', 'Rome', 'Beijing'};

% Carica coastlines una volta
load coastlines

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
guidata(f, handles);

% Callback per mostrare nome e coordinate precise al click su un punto SAR
% (ora la callback viene impostata dopo la creazione della mappa)

% --- Funzione annidata per il calcolo ---

	function calcola_intercettazione(src)
		try
			h = guidata(src);
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
			delta = B^2 - 4*A*C;
			if delta >= 0 && A ~= 0
				t1 = (-B + sqrt(delta))/(2*A);
				t2 = (-B - sqrt(delta))/(2*A);
				tempo = max([t1 t2 0]);
				if tempo <= 0
					tempo = NaN;
				end
			else
				tempo = NaN;
			end

			if ~isnan(tempo)
				% Posizione di intercettazione in coordinate cartesiane
				x_int = x2 + v2x*tempo;
				y_int = y2 + v2y*tempo;
				% Riconversione in lat/lon
				lat_int = lat0 + (y_int/pi/R)*180;
				lon_int = lon0 + (x_int/pi/R)*180/cosd((lat0+lat_int)/2);
				% Rotta da intercettore verso punto di intercettazione
				rotta = azimuth(lat_intc, lon_intc, lat_int, lon_int);
			else
				lat_int = NaN;
				lon_int = NaN;
				rotta = NaN;
			end

			% Chiudi pannelli input
			delete(h.panel_top);
			delete(h.panel_bottom);
			delete(h.btn_calcola);

			% Crea mappa e pannello dati
			ax = worldmap('World');
			set(ax, 'Parent', h.f, 'Position', [0.05 0.05 0.6 0.62]);
			load coastlines
			geoshow(coastlat, coastlon, 'DisplayType', 'polygon', 'FaceColor', [0.5 0.7 1]);
			title('Mappa mondiale (Mapping Toolbox)');

			panel_dati = uipanel('Parent', h.f, 'Title', 'DATI INTERCETTORE / INTERCETTATO', 'FontSize', 12, ...
				'BackgroundColor', [0.95 0.95 0.95], 'Position', [0.68 0.05 0.3 0.93]);

			uicontrol('Parent', panel_dati, 'Style', 'text', 'String', ...
				sprintf('Intercettore:\nLat: %.4f\nLon: %.4f\nVelocità: %.2f kts\n\nIntercettato:\nLat: %.4f\nLon: %.4f\nVelocità: %.2f kts\nPrua: %.1f°\n\nRotta intercettore: %.1f°\nTempo intercettazione: %.2f h', ...
				lat_intc, lon_intc, vel_intc, lat_intd, lon_intd, vel_intd, prua_intd, rotta, tempo), ...
				'Units', 'normalized', 'Position', [0.05 0.05 0.9 0.9], 'FontSize', 12, ...
				'HorizontalAlignment', 'left', 'BackgroundColor', [0.95 0.95 0.95]);

			% Visualizza punti e rotta sulla mappa
			hold on;
			plotm([lat_intc lat_intd], [lon_intc lon_intd], 'g*-', 'LineWidth', 2, 'MarkerSize', 8);
			if ~isnan(lat_int)
				plotm(lat_int, lon_int, 'bp', 'MarkerSize', 12, 'MarkerFaceColor', 'b');
			end

			% Plotta i punti SAR e imposta la callback
			hSAR = plotm(h.sar_lat, h.sar_lon, 'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 4);
			set(hSAR, 'ButtonDownFcn', @(src, event) sar_click_callback(src, h.sar_lat, h.sar_lon, h.sar_names));
			hold off;
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
		if contains(upper(str), 'S') || contains(upper(str), 'W')
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
	textm(lat(idx), lon(idx), txt, 'FontSize', 9, 'BackgroundColor', 'w', 'EdgeColor', 'k', 'Margin', 2);
end

function val = switch_speed(idx)
	switch idx
		case 2
			val = '300';
		case 3
			val = '30';
		otherwise
			val = '';
	end
end
