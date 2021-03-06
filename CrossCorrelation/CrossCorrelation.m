% cross-correlation
% The code aims to calculate time delay between input (blue LED light intensity) and
% output (protein fluorescence intensity) signals using the following equation for G:
% G_(u_deg*y) (taw) = 1/(N-|taw| ) * Sigma(from n = 0 to N-taw+1)[u_deg (n)*y(n+taw)]   taw>=0
% G_(u_deg*y) (taw) = G_(y*u_deg ) (-taw)                    taw<0
% where G_(u_deg*y) (taw) is the cross-correlation between u_deg (input) and y (output) at time lag taw.

% @author Bahareh Mahrou

N = 300;%-----------------------------------% the number of input and output samples
taw= 60;%-----------------------------------% time lag
G = zeros(taw*2+1, 1);%---------------------% cross correlation

%%calculate sigma part of the cross correlation equation
for t = -taw: taw%--------------------------% time lag is changing from -60 to 60 minutes
    if (t >= 0)
        count = 0;%-------------------------%counter of the number of variables in G
        for n = 51: N+1
            if (n+t > N || n+t <= 0)
                G(t+taw+1) = G(t+taw+1) + 0;
            else
                G(t+taw+1) = G(t+taw+1) + u_deg(n)*y(n+t);
                count = count + 1;
            end
        end
        G(t+taw+1) = G(t+taw+1)/count;%-----%cross correlation for time lags >= 0
    else                                
        count = 0;
        for n = 51:N+1
            if (n-t > N || n-t <= 0)
                G(t+taw+1) = G(t+taw+1) + 0;
            else
                G(t+taw+1) = G(t+taw+1) + u_deg (n-t)*y(n);
                count = count + 1;
            end
        end
        G(t+taw+1) = G(t+taw+1)/count;%-----%cross correlation for time lags >= 0
    end
end
%% plot G vs time lag
lag = -taw:taw;
plot (lag, G)
