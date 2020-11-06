function [labels, centroids] = kmeans(I, k, tol)
[m, n, d] = size(I);
N = m*n;
X = reshape(I, N, d);
X_new = zeros(N, d);
indices = zeros(N, 1);
iteration = 0;
variance = 1;
centroids = datasample(X, k);
new_centroid = zeros(k, d);

distance = zeros(k, 1);
while variance > tol
    for i = 1:N % every data point in image array (resized)
        for j = 1:k % every centroid sample (cluster)
            distance(j) = norm(X(i,:)-centroids(j,:),2); % calculate dist
        end
        min_index = find(distance==min(distance)); % index with min distance
        indices(i) = min_index(1);
    end
    % Compute new centroid mean
    for i = 1:k
        index_temp = find(indices == i);
        for j = index_temp'
            new_centroid(i,:) = X(j,:) + new_centroid(i,:);
        end
        new_centroid(i,:) = new_centroid(i,:)/length(index_temp);
        for j = index_temp'
            X_new(j,:) = new_centroid(i,:);
        end
    end    
    variance = norm(abs(centroids - new_centroid), 'fro');
    centroids = new_centroid;
    iteration = iteration + 1;
end
labels = X_new;
end

