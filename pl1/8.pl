% GIVEN IN THE ASSIGNMENT
cargo(tecnico, rogerio).
cargo(tecnico, ivone).
cargo(engenheiro, daniel).
cargo(engenheiro, isabel).
cargo(engenheiro, oscar).
cargo(engenheiro, tomas).
cargo(engenheiro, ana).
cargo(supervisor, luis).
cargo(supervisor_chefe, sonia).
cargo(secretaria_exec, laura).
cargo(diretor, santiago).
chefiado_por(tecnico, engenheiro).
chefiado_por(engenheiro, supervisor).
chefiado_por(analista, supervisor).
chefiado_por(supervisor, supervisor_chefe).
chefiado_por(supervisor_chefe, director).
chefiado_por(secretaria_exec, director).

% a) cargo X que chefia os tecnicos e cargo Y que chefia o X
% engenheiro, supervisor

% b) se a ivone chefia tecnicos mostra todos os cargos ??
% no

% c) mostra os supervisores duas vezes? wtf are this queries
% luis

% d) os cargos e pessoas associadas que são chefiadas pelo supervisor ou supervisor_chefe
% engenheiro, daniel

% e) todos os cargos chefiados pelo director em que a catarina nao assuma um cargo
% supervisor_chefe
