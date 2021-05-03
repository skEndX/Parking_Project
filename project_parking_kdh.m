%% 주차장 및 자동차
x=[0 20];y=[15.5 15.5];y1=[10.5 10.5];y2=[5 5];y_l=[7.75 7.75];
hold on; axis([0 20 0 20]);
line(x,y, 'LineWidth',2);line(x,y1, 'LineWidth',2);
line(x,y2, 'LineWidth',2);line(x,y_l, 'LineWidth',1,'Color','g');

for i=0:2.5:20
y4=[10.5 15.5];y3=[0 5];x1=[i i];
line(x1,y3, 'LineWidth',2);line(x1,y4, 'LineWidth',2);

c_x = [0.3+i 0.3+i 2.5-0.3+i 2.5-0.3+i 0.3+i];
c_y1 = [0.5 4.5 4.5 0.5 0.5]; c_y2=[11 15 15 11 11];
line(c_x, c_y1);line(c_x, c_y2);
fill(c_x, c_y1, 'y');fill(c_x, c_y2, 'y');
end

%% 자동차 출차
v = 0.1115;L = 2.7;theta = 90;

x_m = 13.75;y_m = 2.5;  % 자동차 중심
x_f = x_m; x_r = x_m;    % 바퀴의 x축
y_f = y_m + L/2; y_r = y_m - L/2;   % 바퀴의 y축

x = 0:0.1:3;    % 자동차의 방향을 설정할 delta 값과 주기
delta = -5*cosd(x*110);
delta = [delta, 40*ones(1,30)];
delta = [delta, 40:-y_m/2:0,zeros(1,30)];

for i = 1:1:length(delta)
    % theta값 변화
    theta = theta + v*rad2deg(tand(delta(i))) / L;
        
    % 앞바퀴, 뒷바퀴의 변화
    x_f = [x_f, x_f(i) + v*cosd(theta + delta(i))];
    y_f = [y_f, y_f(i) + v*sind(theta + delta(i))];  
    x_r = [x_r, x_f(i+1) - L * cosd(theta)];
    y_r = [y_r, y_f(i+1) - L * sind(theta)];
    
    % 자동차 중심의 변화
    x_m = (x_r(i+1) + x_f(i+1)) / 2;
    y_m = (y_r(i+1) + y_f(i+1)) / 2;
    
    % 직사각형 자동차을 만들기 위해 점 5개로 이음
    c_x=[-2 -2 2 2 -2]; c_y=[1 -1 -1 1 1];
    
    % 이동시키기 위해 점 5개의 값을 저장
    for j = 1:5
        temp_x(j) = (c_x(j) * cosd(theta) - c_y(j) * sind(theta)) + x_m;
        temp_y(j) = (c_x(j) * sind(theta) + c_y(j) * cosd(theta)) + y_m;
    end
    
    fill(temp_x, temp_y, 'y');
    plot(x_f,y_f,'LineWidth',2,'Color','r');
    plot(x_r,y_r,'LineWidth',2,'Color','b');   
    drawnow
end